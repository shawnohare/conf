# These are the different profiles that can be used when building on MacOS.
# Corresponds to ~/.nixpkgs/darwin-configuration.nix in a simple nix-darwin
# install.
#
# There are sufficient differences between between older
# Intel-based machines and the newer Apple Silicon
# ones that we split the configuration. Eventually
# the
#
#  flake.nix
#   └─ ./darwin
#       ├─ ./default.nix *
#       ├─ configuration.nix
#       └─ home.nix
#

{ lib, inputs, nixpkgs, home-manager, darwin, user, ...}:

{
  macbook_intel = darwin.lib.darwinSystem {
    system = "x86_64-darwin";
    specialArgs = { inherit user inputs; };
    modules = [                                             # Modules that are used
      ./configuration.nix
      
      home-manager.darwinModules.home-manager {             # Home-Manager module that is used
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit user; };  # Pass flake variable
        home-manager.users.${user} = import ./home.nix;
      }
    ];
  };
}
