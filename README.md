# Config (nixos, nix-darwin, home-manager, devbox)

## Introduction

This repo primarily consists as an exercise in using a nix flake to manage
our system / user configurations via nixpkgs, home-manager, devbox and standard
symlink farming.

We hope it serves as a personal motivation to investigate NixOS more generally.
For this reason we purposefully avoid some of the more layered frameworks (and
their utility libraries) mentioned in the [References](#References) below, but
try to take some structural cues.

The primary management options are

1. NixOS: include home-manager as a module.
1. macOS: Use nix-darwin on macOS and include home-manager as a module. We have
   run into some issues with nix-darwin after system updates.
1. Linux / macOS: Use home-manager in a standalone fashion, but configured within the
   flake. This is the only option for non-NixOS Linux distributions.

## Package management

The tools we use generally fall into the following categories.

1. Common, relatively static utilities we rarely update. These can be
   effectively managed by a stable release of nixpkgs, or the system
   package manager.
2. Applications and toolchains we wish to update frequently (e.g., neovim).
3. Applications not available to nixpkgs.

When using a stable version of `nixpkgs`, there does not seem to be an elegant
way of frequently updating individual packages.

In our setup we prefer to follow nixpkgs-unstable and install most packages
with either `home-manager` or `devbox global`.

Update a specific flake input

```bash
nix flake lock --update-input nixpkgs --update-input <package>`
```
or equivalently
```bash
bin/switch update <package>
```

## Structure

- [host](./host): Contains system specific configurations.
   In theory these configurations are at the highest level,
   but we suspect that architecture-specific configurations leak into lower
   levels, e.g., with new Apple Silicon based macs.
   Cf. [Mitchell Hashimoto's nixos setup][mitchellh_nixos_config] to see how
   vms are used to abstract some of these nuances away. We may settle upon
   a pattern where some hosts are abstract, to have common files to apply to
   a company mandated MacBook vs a personal one.
- [home (home-manager)](./home): The user-specific program configurations
   that will be managed by home-manager. Typicaly these profiles are host
   agnostic to the extent possible.
- [lib](./lib/): Common boilerplate library functions used in this
  flake, e.g., for building nix-darwin and standalone home-manager configurations.
- [overlays](./overlays) containing package overrides, e.g., to use a
   different channel. Not used much if at all at the moment.
- [etc](./etc): Configurations not managed by home-manager, but
  via a symlink farm manager.

## Install nix

On platforms other than NixOS, we must first install nix itself in order to
build the flake.

```bash
if [ "$(uname -s)" = "Darwin" ]; then
    xcode-select --install
fi
sh <(curl -L https://nixos.org/nix/install) --daemon
```
or using the DeterminateSystems installer from
https://github.com/DeterminateSystems/nix-installer.
Note that this installer will not result in an identical setup as the official
installer. In particular, some default channels are not necessarily set. This
has made uninstalling nix-darwin a pain.

```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```
or, to via devbox

```bash
curl -fsSL https://get.jetpack.io/devbox | bash
```

## macOS

macOS systems can managed with a combination of nix-darwin and home-manager.
nix-darwin surfaces a NixOS like system configuration at the system level. The
basic options are

1. Build nix-darwin and include home-manager as a nix-darwin module. In theory this
   option is preferred, but we have run into some stability issues
1. Build a stand-alone home-manager.

### nix-darwin

We install nix-darwin by building this flake for a specific host. For
example, `host ∈ {work, macbook, intel, ...}` and should correspond to one of
`darwinConfigurations` in [flake.nix](./flake.nix).
WARNING: We have runRiIto some NG:bi ity issues when e tempthng ta use vix-darwin. Presentlye runito some biity issues when temptng t use ix-darwin. Presently
Below are some possible steps to perform after installing nix but
before switching the configuration with nix-darwin.

Clone and build the flake for a specified target, e.g

```bash
git clone https://github.com/shawnohare/conf
cd conf
nix --extra-experimental-features "nix-command flakes" build ".#darwinConfigurations.${host}.system"
result/sw/bin/darwin-rebuild switch --flake ".#${host}"
```
mbp2022mbp2022
Alternatively
```bash
bin/switch --system ${host}
# for example
bin/switch --system work
```

nix-darwin might fail if it cannot find `/run`. Try

```bash
printf 'run\tprivate/var/run\n' | sudo tee -a /etc/synthetic.conf
/System/Library/Filesystems/apfs.fs/Contents/Resources/apfs.util -t
```

nix-darwin might fail to write certain files if they already exist. Try
```bash
sudo mv /etc/nix/nix.conf /etc/nix/nix.conf.before-nix-darwin
sudo mv /etc/shells /etc/shells.before-nix-darwin
sudo mv /etc/bashrc /etc/bashrc.before-nix-darwin
sudo mv /etc/zshrc /etc/zshrc.before-nix-darwin
```

### nix-darwin rebuilding

After the flake is built, `darwin-rebuild` is available. Rebuild the
configuration via

```bash
darwin-rebuild switch --flake "#${host}"
# or
bin/switch system ${host}
```

## home-manager

`home-manager` deals with user-level configuration. For macOS and non-NixOS Linux
systems it is possible to install home-manager in standalone mode. To do this,
simply omit the system building steps outlined above.

```bash
nix build --extra-experimental-features "nix-command flakes" ".#homeConfigurations.${host}.activationPackage"
./result/activate
# or
bin/switch home ${host}
```

## Management of config files

Originally we managed configuration files via committing them to a version
controlled repository and then symlinking them into the appropriate location
via tools such as GNU `stow`. The benefit here is that once the files are
linked, changes can be made to the source and they will propagate without
re-linking.

Then we utilized a bare git repository that contained all configuration files.
The benefit here is that there are no symlinks at all, so changes are immediate
and require no rebuilds. The downside with a bare repo is that one must
explicitly pass the git dir and work tree as arguments to `git`, which itself
is more or less trivial. But then the basic commands tend to have a lot of
clutter. Many things get ignored, there are many untracked files, etc.

Using home-manager's builtin modules to configure applications or even the
symlinking capabilities does involve a rebuild after any configuration change.
This is because the source file in the repository gets copied to the nix store
and then linked. For rapid configuration changes this is a bit of a pain.


# References

- This flake was initially a near clone of
  [Matthias' NixOS & macOS configuration flake][matthias_nixos_config]
- The [digga][digga] project also provides a flake template and lib for
  highly structured and modularized configs.
- [Mitchell Hashimoto's nixos config][mitchellh_nixos_config]
- [flake-utils-plus][flake-utils-plus]





[digga]: https://github.com/divnix/digga
[matthias_nixos_config]: <https://github.com/MatthiasBenaets/nixos-config>
[mitchellh_nixos_config]: <https://github.com/mitchellh/nixos-config>
[flake-utils-plus]: <https://github.com/gytis-ivaskevicius/flake-utils-plus>
