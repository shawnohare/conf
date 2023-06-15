# This function creates a home-manager configuration.
{
  inputs,
  home-manager,
  host,
  ...
}:
home-manager.lib.homeManagerConfiguration rec {
  pkgs = host.nixpkgs.legacyPackages.${host.system};
  extraSpecialArgs = {inherit inputs host;};
  modules =
    [
      ../hm/common/home.nix
    ]
    ++ host.hm_modules;
}
