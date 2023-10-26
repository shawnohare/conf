# nixos-config

This configuration repo primarily consists of a nix flake as an exercise to our
system / user configurations via nix flakes, home-manager, and standard
symlink farming.

We hope it serves as a personal motivation to investigate NixOS more generally.
For this reason we purposefully avoid some of the more structured and layered
frameworks and their utility libraries mentioned in the
[References](#References) below,
but try to take some structural cues.

The primary management options are

1. Use NixOS and include home-manager as a module.
1. Use nix-darwin on macOS and include home-manager as a module. We have run into
   some issues with nix-darwin, and currently recommend the next option for macOS.
1. Use home-manager in a standalone fashion on macOS or non-NixOS distributions.


## Structure

- [system](./system): Contains platform specific configurations. 
   In theory these configurations are at the highest level,
   but we suspect that architecture-specific configurations leak into lower
   levels, e.g., with new Apple Silicon based macs.
   Cf. [Mitchell Hashimoto's nixos setup][mitchellh_nixos_config] to see how
   vms are used to abstract some of these nuances away. We may settle upon
   a pattern where some hosts are abstract, to have common files to apply to
   a company mandated MacBook vs a personal one.
- [profiles](./profiles/): Contains collections of configurations for a specific
   operating mode, e.g., system-wide package configurations. Our normal
   style is to push most package configurations to the user level.
- [hm (home-manager)](./hm): The user-specific program configurations
   that will be managed by home-manager. Typicaly these profiles are host
   agnostic to the extent possible.
- [lib directory](./lib/): Common boilerplate library functions used in this
  flake, e.g., for building nix-darwin and home-manager configurations.
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
# or
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```
The latter installation method is from https://github.com/DeterminateSystems/nix-installer.

## macOS

macOS systems can managed with a combination of nix-darwin and home-manager.
nix-darwin surfaces a NixOS like system configuration for
macs at the system level. The basic options are

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
sudo mv /etc/nix/nix.conf /etc/nix/nix-darwin.bak.nix.conf
sudo mv /etc/shells /etc/nix-darwin.bak.shells
```

### nix-darwin rebuilding

After the initialization `darwin-rebuild` is available and the configuration
can be rebuilt via

```bash
darwin-rebuild switch --flake "~/nixos-config#${host}"
# or
bin/switch --system ${host}
```

We must obtain the nix package manager and build the flake, which will
provide nix-darwin and home-manager.

## home-manager

`home-manager` deals with user-level management. For macOS and non-NixOS Linux
systems it is possible to install home-manager in standalone mode. To do this,
simply omit the system building steps outlined above.

```bash
nix build --extra-experimental-features "nix-command flakes" ".#homeConfigurations.${host}.activationPackage"
./result/activate
# or
bin/switch --home ${host}
```

## Management of config files

Originally we managed configuration files via committing them to a version
controlled repository and then symlinking them into the appropriate location
via tools such as GNU `stow` or our own bash replacement. The benefit here is
that once the files are linked, changes can be made to the source and they will
propagate without re-linking. Only when new files are added do we need to
re-link.

Then we utilized a bare git repository that contained all configuration files.
The benefit here is that there are no symlinks at all, so changes are immediate
and require no rebuilds. The downside with a bare repo is that one must
explicitly pass the git dir and work tree as arguments to `git`, which itself
is more or less trivial. But then the basic commands tend to have a lot of
clutter. Many things get ignored, there are many untracked files, etc.


Using home-manager's builtin modules to configure applications or even the
symlinking capabilities does involve a rebuild after any configuration change.
This is because the source file in the repository gets copied to the nix store
and then linked. For rapid configuration changes this is a bit of a pain, but
can be alleviated perhaps by manually symlinking the file.

Presently most of our configuration files are managed via the bare git
repository strategy, but ideally they are centralized in a single location. Our
plan is to move more configuration over to home-manager modules once the
underlying configuration is mature. There is a mild downside to this approach
in that it introduces yet another abstraction layer over the configuration
files. The long term benefit is that mature applications will likely have
robust home-manager modules.


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
