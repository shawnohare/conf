# This function creates a home-manager configuration.
# It is intended to be used with standalone home-manager
# setups, such as thos in a non-NixOS linux environment
# or macOS without nix-darwin.
{
  inputs,
  home-manager,
  target,
  ...
}:
home-manager.lib.homeManagerConfiguration rec {
  pkgs = target.home.nixpkgs.legacyPackages.${target.host.system};
  extraSpecialArgs = {inherit inputs target;};
  modules = [
    ../home/${target.home.config}
  ];
}
