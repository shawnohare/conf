{
  description = "My NixOS and Darwin Configuration Flake";

  # Configurations to use when evaluating the flake.
  # cf. `nix help flake` for more
  nixConfig = {
    extra-experimental-features = "nix-command flakes";
    extra-substituters = "https://nrdxp.cachix.org https://nix-community.cachix.org";
    # extra-trusted-public-keys = "nrdxp.cachix.org-1:Fc5PSqY2Jm1TrWfm88l6cvGWwz3s93c6IOifQWnhNW4= nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=";
  };

  inputs = {
    # Track channels with commits tested and built by hydra
    # For darwin hosts: it can be helpful to track this darwin-specific stable
    # channel equivalent to the `nixos-*` channels for NixOS. For one, these
    # channels are more likely to provide cached binaries for darwin systems.
    # But, perhaps even more usefully, it provides a place for adding
    # darwin-specific overlays and packages which could otherwise cause build
    # failures on Linux systems.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-22.05-darwin";
    nixpkgs-darwin-unstable.url = "github:nixos/nixpkgs/nixpkgs-22.05-darwin";

    home-manager = {
      url = "github:nix-community/home-manager/release-22.05";
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
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    darwin,
    nur,
    # , nixgl
    # , hyprland
    ...
  }: let
    mkDarwin = import ./lib/mkDarwin.nix;
    # Define user profiles, which correspond roughly with how we use the
    # machine. Currently this serves only to distinguish a company provided
    # laptop (usually macbook) from other uses.
    userProfiles = {
      work = {
        name = "user";
        dir = "work";
      };
      admin = {
        name = "shawn";
        dir = "shawn";
      };
    };
  in {
    inherit self inputs;

    # Also inherit home-manager so it does not need to be defined here.
    # nixosConfigurations = (                                               # NixOS configurations
    #   import ./hosts/nixos{                                                     # Imports ./nixos/default.nix
    #     inherit (nixpkgs) lib;
    #     inherit inputs nixpkgs home nur user location hyprland;
    #   }
    # );

    darwinConfigurations = {
      work = mkDarwin rec {
        inherit darwin home-manager inputs;
        nixpkgs = inputs.nixpkgs-darwin;
        system = "x86_64-darwin";
        user = userProfiles.work;
        overlays = 0;
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
    };
  };
}
