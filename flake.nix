#  flake.nix *
#   ├─ ./hosts
#   │   └─ default.nix
#   ├─ ./darwin
#   │   └─ default.nix
#   └─ ./nix
#       └─ default.nix
#

{
  description = "My NixOS and Darwin Configuration Flake";

  inputs =                                                                  # All flake references used to build my NixOS setup. These are dependencies.
    {
      nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";                  # Nix Packages

      home-manager = {                                                      # User Package Management
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      # macos system management
      darwin = {
        url = "github:lnl7/nix-darwin/master";                              # MacOS Package Management
        inputs.nixpkgs.follows = "nixpkgs";
      };

      nur = {
        url = "github:nix-community/NUR";                                   # NUR packages
      };

      nixgl = {                                                             #OpenGL 
        url = "github:guibou/nixGL";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      hyprland = {
        url = "github:vaxerski/Hyprland";
        inputs.nixpkgs.follows = "nixpkgs";
      };
    };

  outputs = inputs @ { self, nixpkgs, home-manager, darwin, nur, nixgl, hyprland, ... }:
    # Variables that are passed to the config files.
    let
      user =
      home = builtins.getEnv "HOME"
      location = "$HOME/.setup";
    in                                                                      # Use above variables in ...
    {
      nixosConfigurations = (                                               # NixOS configurations
        import ./nixos{                                                     # Imports ./nixos/default.nix
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs home-manager nur user location hyprland;   # Also inherit home-manager so it does not need to be defined here.
        }
      );

      macosConfigurations = (                                              # macOS Configurations
        import ./darwin {
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs home-manager darwin user;
        }
      );

      linuxConfigurations = (                                                # Non-NixOS configurations
        import ./linux {
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs home-manager nixgl user;
        }
      );
    };
}
