# This function creates a home-manager configuration.
{
  inputs,
  nixpkgs,
  home-manager,
  system,
  username,
  homeDirectory,
  stateVersion,
  additional_modules,
  overlays,
  ...
}:
home-manager.lib.homeManagerConfiguration rec {
  pkgs = nixpkgs.legacyPackages.${system};
  extraSpecialArgs = {inherit inputs username;};
  modules =
    [
      ../hm/common/home.nix
    ]
    ++ additional_modules;
}
