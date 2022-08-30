# Introduction

This configuration flake presently represents an initial exercise into managing
our system and user configurations via nix flakes and home-manager. Moreover we
hope it serves as a motivation to investigate NixOS more generally. For this
reason we purposefully avoid some of the more structured and layered frameworks
and their utility libraries mentioned in the [References](#References) below,
but try to take some structural cues.

We maintain another repo of user configurations.

# Structure

1. Machine specific configurations are defined by a directory in
   [hosts](./hosts/). In theory these configurations are at the highest level,
   but we suspect that architecture-specific configurations leak into lower
   levels, e.g., with new Apple Silicon based macs.
   Cf. [Mitchell Hashimoto's nixos setup][mitchellh_nixos_config] to see how
   vms are used to abstract some of these nuances away. We may settle upon
   a pattern where some hosts are abstract, to have common files to apply to
   a company mandated MacBook vs a personal one. This would be obviated to
   an extent if we worked mostly inside of vms for what little development
   work we do.
1. [profiles](./profiles/) contains collections of configurations for a specific
   operating mode, e.g., system-wide package configurations. Our normal
   style is to push most package configurations to the user level.
1. [users](./users/) largely contains home-manager configurations and is a
   special type of profile. Only NixOS and macOS have `nixos-rebuild switch`
   capabilities that can redefine the entire system and user-space, so
   generic Linux targets (e.g., An Amazon Linux EC2 instance) would have to
   rely on `home-manager`. Cf.
   [Matthias' NixOS & Darwin Config][matthias_nixos_config] for a flake that
   defines host targets for all three types of hosts
   (NixOS, macOS, non-NixOS linux).
    1. [users/profiles](./users/profiles) The user-specific program configurations
       that will be managed by home-manager. Typicaly these profiles are host
       agnostic to the extent possible.
    1. The `users/<user>`
1. [lib directory](./lib/) for common library functions used in this flake.
   These libs will serve to implement some of the boilerplate that gets
   taken care of by [flake-utils-plus][flake-utils-plus] or [digg][digga].
   Most likely we will end up using an external library once we are
   comfortable enough with nix.
1. [overlays](./overlays) containing package overrides, e.g., to use a
   different channel


# macOS

macOS systems are managed with nix-darwin and home-manager.
nix-darwin surfaces a NixOS like system configuration for
macs.

## Installation

### init

We install nix-darwin by building this flake for a specific machine host. For
example, `host ∈ {work, macbook, intel, ...}` and should correspond to one of
`darwinConfigurations` in [flake.nix](./flake.nix).

```bash
export CONFIG_HOME="$HOME/nixos-config"
export host=<machine>
# get basic dev tools, including git
xcode-select --install
# get nixos
sh <(curl -L https://nixos.org/nix/install)
# get flake
git clone https://github.com/shawnohare/nixos-config "${CONFIG_HOME}"
cd "${CONFIG_HOME}"
nix --extra-experimental-features "nix-command flakes" build "${CONFIG_HOME}#darwinConfigurations.${host}.system"
result/sw/bin/darwin-rebuild switch --flake "${CONFIG_HOME}#${host}"
#
```

### Rebuilding

After the initialization `darwin-rebuild` is available and the configuration
can be rebuilt via

```bash
darwin-rebuild switch --flake "${CONFIG_HOME}#${host}"
```

We must obtain the nix package manager and build the flake, which will
provide nix-darwin and home-manager.


# References

- This flake was initially a near clone of
  [Matthias' NixOS & macOS configuration flake][matthias_nixos_config]
- The [digga][digga] project also provides a flake template and lib for
  highly structured and modularized configs.
- [Mitchell Hashimoto's nixos config][mitcchellh_nixos_config]
- [flake-utils-plus][flake-utils-plus]





[digga]: https://github.com/divnix/digga
[matthias_nixos_config]: <https://github.com/MatthiasBenaets/nixos-config>
[mitchellh_nixos_config]: <https://github.com/mitchellh/nixos-config>
[flake-utils-plus]: <https://github.com/gytis-ivaskevicius/flake-utils-plus>
