# configuration using nixos, nix-darwin, home-manager, devbox

## Introduction

This repo primarily consists as an exercise in using a nix flake to manage
our system / user configurations via nixpkgs, home-manager, devbox and standard
symlink farming.

We hope it serves as a personal motivation to investigate NixOS more generally.
For this reason we purposefully avoid some of the more layered frameworks (and
their utility libraries) mentioned in the [References](#References) below, but
try to take some structural cues.


## Setup

###  Install nix

Except on NixOS, we must install nix (the package manager) itself to build the flake.

#### DeterminateSystems installer (preferred)

Note that this installer will not result in an identical setup as the official
installer. In particular, some default channels are not necessarily set. This
can make uninstalling nix-darwin a pain.
Confer https://github.com/DeterminateSystems/nix-installer for nuances.

```bash
if [ "$(uname -s)" = "Darwin" ]; then
    xcode-select --install
fi
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

#### Official installer

```bash
if [ "$(uname -s)" = "Darwin" ]; then
    xcode-select --install
fi
sh <(curl -L https://nixos.org/nix/install) --daemon
```

### macOS

macOS systems can managed with a combination of nix-darwin and home-manager.
nix-darwin surfaces a NixOS like system configuration at the system level. The
basic options are

1. Build nix-darwin and include home-manager as a nix-darwin module. In theory this
   option is preferred, but we have run into some stability issues
1. Build a stand-alone home-manager.

#### Install nix-darwin

We install nix-darwin by building this flake for a specific host (e.g., "work")
corresponds to one the `darwinConfigurations` attributes in
[flake.nix](./flake.nix).

Clone and build the flake for a specified target, e.g.,

```bash
git clone https://github.com/shawnohare/conf
cd conf
host=work # defaults to $(hostname -s) if omitted
./switch "${host}"
# or
nix --extra-experimental-features "nix-command flakes" build ".#darwinConfigurations.${host}.system"
result/sw/bin/darwin-rebuild switch --flake ".#${host}"
```

#### nix-darwin rebuilding

After nix-darwin is built, `darwin-rebuild` is available. Rebuild the system
and user configuration via

```bash
./switch "${host}"
# or
darwin-rebuild switch --flake "#${host}"
```

#### Troubleshooting nix-darwin

After initially installing nix or macOS updates `nix-darwin switch` can fail
for a variety of reasons.


nix-darwin might fail if it cannot find `/run`. Try

```bash
printf 'run\tprivate/var/run\n' | sudo tee -a /etc/synthetic.conf
/System/Library/Filesystems/apfs.fs/Contents/Resources/apfs.util -t
```

nix-darwin might fail to write certain files if they already exist. Try
```bash
./switch backup
# or
sudo mv /etc/nix/nix.conf /etc/nix/nix.conf.before-nix-darwin
sudo mv /etc/shells /etc/shells.before-nix-darwin
sudo mv /etc/bashrc /etc/bashrc.before-nix-darwin
sudo mv /etc/zshrc /etc/zshrc.before-nix-darwin
sudo mv /etc/zshenv /etc/zshenv.before-nix-darwin
```


## home-manager

`home-manager` deals with user-level configuration. For macOS and non-NixOS Linux
systems it is possible to install home-manager in standalone mode. To do this,
simply omit the system building steps outlined above.

```bash
nix build --extra-experimental-features "nix-command flakes" ".#homeConfigurations.${host}.activationPackage"
./result/activate
# or
./switch home ${host}
```

## Repo Structure

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


## Package management

The primary management options are

1. NixOS: include home-manager as a module.
1. macOS: Use nix-darwin on macOS and include home-manager as a module. This
   is generally our preferred method on macOS, though it does mean switching
   user configurations entails a system switch and sudo password.
1. Linux / macOS: Use home-manager in a standalone fashion, but configured
   within the flake. This is the only option for non-NixOS Linux distributions.


The tools we use generally fall into the following categories.

1. Common, relatively static utilities we rarely update. These can be
   effectively managed by a stable release of nixpkgs, or the system
   package manager.
2. Applications and toolchains we wish to update frequently (e.g., neovim).
3. Applications not available to nixpkgs or more easily installed manually,
   e.g., many macOS GUI applications.

When using a stable version of `nixpkgs`, there does not seem to be an elegant
way of frequently updating individual packages.

In our setup we prefer to follow nixpkgs-unstable and install most packages
with either `home-manager` or `devbox global`.

### Updating flake inputs

It is a good idea to periodically update the flake's lockfile.

To update a specific flake input (e.g., nixpkgs in the example)

```bash
nix flake update nixpkgs
# previously
nix flake lock --update-input nixpkgs --update-input <package>`
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

## macOS Applications

Some applications we like to use while on macOS that are generally not managed
by this repo are

- 1password
- Raycast (spotlight replacement)
- raindrop.io (bookmark manager)
- obsidian.md (notes)
- Orion & firefox (web browser)


## References

- This flake was initially a near clone of
  [Matthias' NixOS & macOS configuration flake][matthias_nixos_config]
- [Mitchell Hashimoto's nixos config][mitchellh_nixos_config]
- [flake-utils-plus][flake-utils-plus]


[matthias_nixos_config]: <https://github.com/MatthiasBenaets/nixos-config>
[mitchellh_nixos_config]: <https://github.com/mitchellh/nixos-config>
[flake-utils-plus]: <https://github.com/gytis-ivaskevicius/flake-utils-plus>
