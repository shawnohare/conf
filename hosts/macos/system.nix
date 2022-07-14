# Create a darwin system.
{ config, nixpkgs, pkgs, user, darwin ... }:
darwin.lib.darwinSystem {
  system = "x86_64-darwin";
  specialArgs = {
    inherit inputs location user;
  };
  modules = [
    ./configuration.nix
    home-manager.darwinModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = {
          inherit user
            };
            users.${ user} = import./home.nix;
          };
          }
          ];
          };
