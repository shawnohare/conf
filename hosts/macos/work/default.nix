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

{ lib, inputs, nixpkgs, home-manager, darwin, user, home, location, ... }:

{
  # Placeholder for Apple Silicon mac(book)s. We currently do not have
  # access to one.
  macbook = darwin.lib.darwinSystem {
    system = "arch64-darwin";
    specialArgs = { inherit user inputs location; };
    modules = [
      # Modules that are used
      ./configuration.nix

      # Should this go more properly in configuration.nix?
      home-manager.darwinModules.home-manager
      {
        # Home-Manager module that is used
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = { inherit user home; }; # Pass flake variable
          users.${user} = import ./home.nix;
        };
      }
    ];
  };
  macbook_intel = darwin.lib.darwinSystem {
    system = "x86_64-darwin";
    specialArgs = { inherit user inputs location; };
    modules = [
      # Modules that are used
      ./configuration.nix

      # Should this go more properly in configuration.nix?
      home-manager.darwinModules.home-manager
      {
        # Home-Manager module that is used
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = { inherit user home; }; # Pass flake variable
          users.${user} = import ./home.nix;
        };
      }
    ];
  };
  # Define a profile for company provided machines, which typically are
  # macbooks of some flavor. s
  # one is unable to create a new admin user on a macOS system or where
  # one wishes to utilize the company provided configurations (e.g., vpn).
  # There is likely a more elegant way to achieve this, but currently we have
  # been unable to extract the underlying username when invoking
  # nix build.
  work = darwin.lib.darwinSystem {
    system = "x86_64-darwin";
    specialArgs = { inherit user inputs location; };
    modules = [
      # Modules that are used
      ./configuration.nix

      # Should this go more properly in configuration.nix?
      home-manager.darwinModules.home-manager
      {
        # Home-Manager module that is used
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = {
            user = "user";
          };
          users.user = import ./home.nix;
        };
      }
    ];
  };
}
