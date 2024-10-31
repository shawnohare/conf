{
  description = "My NixOS and Darwin Configuration Flake";

  # Configurations to use when evaluating the flake.
  # cf. `nix help flake` for more
  nixConfig = {
    extra-experimental-features = "nix-command flakes";
  };

  inputs = {
    # Track channels with commits tested and built by hydra
    # For darwin hosts: it can be helpful to track this darwin-specific stable
    # channel equivalent to the `nixos-*` channels for NixOS. For one, these
    # channels are more likely to provide cached binaries for darwin systems.
    # But, perhaps even more usefully, it provides a place for adding
    # darwin-specific overlays and packages which could otherwise cause build
    # failures on Linux systems.

    # determinate systems
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/0.1";

    # stable nixpkgs
    nixpkgs-stable.url = "github:nixos/nixpkgs/release-23.11";
    nixpkgs-stable-darwin.url = "github:nixos/nixpkgs/nixpkgs-23.11-darwin";
    # unstable nixpkgs (can be used to get more frequent updates)
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-unstable";


    home-manager = {
      # stable must be linked to the corresponding nixpkgs stable
      # url = "github:nix-community/home-manager/release-23.05";
      # url = "github:nix-community/home-manager/release-23.11";
      # unstable
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nix-darwin provides a system configuration layer for macOS that's
    # similar to what's provided in NixOS.
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

    nixos-hardware.url = "github:nixos/nixos-hardware";
    nixos-generators.url = "github:nix-community/nixos-generators";

    nur = {
      url = "github:nix-community/NUR";
    };

    # nixgl = {
    #   url = "github:guibou/nixGL";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # hyprland = {
    #   url = "github:vaxerski/Hyprland";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    alejandra = {
      url = "github:kamadorueda/alejandra/3.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    darwin,
    nur,
    determinate,
    # alejandra,
    # , nixgl
    # , hyprland
    ...
  }: let
    mkDarwin = import ./lib/mkDarwin.nix;
    mkHomeConfiguration = import ./lib/mkHomeConfiguration.nix;

    # Each target context effectively represents a profile
    # for a specific host. That is, a specification of system
    # and user configurations.
    # Each target can have the following attributes
    # - user.name: The hardcoded username used in both system and home configs.
    # - host.config: The system level configuration to use with nixOS or nix-darwin.
    # - host.system: The system architecture and OS string.
    # - home.config: The user level configuration to use with home-manager.
    # - home.nixpkgs: The version of nixpkgs to use to set the pkgs attribute
    # - home.stateVersion: The home-manager state version.
    #   in a standalone home-manager context.
    targets = rec {
      # Default settings for hosts / machines.
      default = {
        home.stateVersion = "23.11";
        home.config = "default.nix";
      };

      macos.arm = {
        host.system = "aarch64-darwin";
        host.config = "aarch64-darwin.nix";
        home.stateVersion = default.home.stateVersion;
        home.config = default.home.config;
        home.nixpkgs = inputs.nixpkgs-darwin;
      };

      macos.intel = {
        host.system = "x86_64-darwin";
        host.config = "x86_64-darwin.nix";
        home = macos.arm.home;
      };

      nixos = {
        host.config = "nixos.nix";
        home.stateVersion = default.home.stateVersion;
        home.config = default.home.config;
        home.nixpkgs = inputs.nixpkgs;
      };

      # Target hosts / machines.
      work = {
        user.name = "Shawn.OHare";
        host = macos.arm.host;
        home = macos.arm.home;
        overlays = 0;
      };

      mbp2016 = {
        user.name = "shawn";
        description = "MacBook Pro 2016";
        host = macos.intel.host;
        home = macos.intel.home;
        overlays = 0;
      };

      mba2022 = {
        user.name = "shawn";
        description = "MacBook Air 2022";
        host = macos.arm.host;
        home = macos.arm.home;
        overlays = 0;
        homebrew.enable = false;
      };
    };
  in {
    inherit self inputs;

    # TODO: Add nixos configurations.
    # nixosConfigurations = (                                               # NixOS configurations
    #   import ./hosts/nixos{                                                     # Imports ./nixos/default.nix
    #     inherit (nixpkgs) lib;
    #     inherit inputs nixpkgs home nur user location hyprland;
    #   }
    # );

    # Build system configurations.
    darwinConfigurations = {
      mbp2016 = mkDarwin {
        inherit darwin home-manager inputs determinate;
        target = targets.mbp2016;
      };

      air = mkDarwin {
        inherit darwin home-manager inputs determinate;
        target = targets.mba2022;
      };

      work = mkDarwin {
        inherit darwin home-manager inputs determinate;
        target = targets.work;
      };
    };

    # Stand-alone home-manager configurations so that user configs
    # can be rebuilt independently of the system itself.
    # cf. https://github.com/MatthiasBenaets/nixos-config/blob/master/nix.org
    # TODO: We should be able to use "forEachSystem" here to generate
    # configs for each system that use the appropriate pkgs.
    homeConfigurations = {
      work = mkHomeConfiguration {
        inherit home-manager inputs;
        target = targets.work;
      };

      shawn = mkHomeConfiguration {
        inherit home-manager inputs;
        target = targets.mba2022;
      };

      # configs keyed with user names allow simply running `switch` to update
      # home manager configurations.
      "Shawn.OHare" = mkHomeConfiguration {
        inherit home-manager inputs;
        target = targets.work;
      };
    };

    # Configurations that do not have "nixos-rebuild" capability.
    # linuxConfigurations = (                                                # Non-NixOS configurations
    #   import ./hosts/linux {
    #     inherit (nixpkgs) lib;
    #     inherit inputs nixpkgs home nixgl user location;
    #   }
    # );

    formatter = {
      x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;
      x86_64-darwin = nixpkgs.legacyPackages.x86_64-darwin.alejandra;
      aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.alejandra;
    };
  };
}
