# These are the different profiles that can be used when building on MacOS.
# Corresponds to components of ~/.nixpkgs/darwin-configuration.nix
# in a simple nix-darwin install.
#
# There are sufficient differences between between older Intel-based machines
# and the newer Apple Silicon ones that we split the configuration. Eventually
# the
#
#  flake.nix
#   └─ ./darwin
#       ├─ ./default.nix *
#       ├─ configuration.nix
#       └─ home.nix
#

{ inputs, nixpkgs, home-manager, darwin, user, location, ... }:

let
  # We just hard-code our work user for now under the assumption that
  # we are not performing user management on such machines.
  mkSystem = { system, user, home }: darwin.lib.darwinSystem {
    inherit system;
    specialArgs = { inherit user inputs location; };
    modules = [
      ./configuration.nix
      home-manager.darwinModules.home-manager
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = { inherit user; }; # Pass flake variable
          users.${user} = import ./${home};
        };
      }
    ];
  };
in
{
  # function to create a darwinSystem instance. It is very crude
  # and serves more as an exercise.

  # Define a host for company provided machines, which often are
  # macbooks of some flavor. Typically the user and various network components
  # are predefined, thus the configuration focuses on standard options
  # and work-related packages.
  work = mkSystem {
    system = "x86_64-darwin";
    user = builtins.baseNameOf (builtins.getEnv "HOME");
    home = "home.nix";
  };

  # Placeholder for Apple Silicon mac(book)s. We currently do not have
  # access to one.
  # macbook = darwin.lib.darwinSystem {
  #   system = "arch64-darwin";
  #   specialArgs = { inherit user inputs location; };
  #   modules = [                                             # Modules that are used
  #     ./configuration.nix

  #     # Should this go more properly in configuration.nix?
  #     home-manager.darwinModules.home-manager {             # Home-Manager module that is used
  #       home-manager = {
  #           useGlobalPkgs = true;
  #           useUserPackages = true;
  #           extraSpecialArgs = { inherit user; };  # Pass flake variable
  #           users.${user} = import ./home.nix;
  #       };
  #     }
  #   ];
  # };

  # Macs with Intel CPUs. We expect our access to these will diminish.
  # intel = darwin.lib.darwinSystem {
  #   system = "x86_64-darwin";
  #   specialArgs = { inherit user inputs location; };
  #   modules = [                                             # Modules that are used
  #     # ./intel
  #     ./configuration.nix

  #     # Should this go more properly in configuration.nix?
  #     home-manager.darwinModules.home-manager {             # Home-Manager module that is used
  #       home-manager = {
  #           useGlobalPkgs = true;
  #           useUserPackages = true;
  #           extraSpecialArgs = { inherit user; };  # Pass flake variable
  #           users.${user} = import ./home.nix;
  #       };
  #     }
  #   ];
  # };

  # work = darwin.lib.darwinSystem {
  #   system = "x86_64-darwin";
  #   specialArgs = {
  #     # user = "${work_user}";
  #     inherit inputs location;
  #   };
  #   modules = [                                             # Modules that are used
  #     # ./work
  #     ./configuration.nix
  #     # Should this go more properly in configuration.nix?
  #     home-manager.darwinModules.home-manager {             # Home-Manager module that is used
  #       home-manager = {
  #           useGlobalPkgs = true;
  #           useUserPackages = true;
  #           extraSpecialArgs = {
  #               user = "${work_user}";
  #           };
  #           users.main = import ./home.nix;
  #       };
  #     }
  #   ];
  # };
}
