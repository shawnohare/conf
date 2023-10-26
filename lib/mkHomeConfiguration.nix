# This function creates a home-manager configuration.
# It is intended to be used with standalone home-manager
# setups, such as thos in a non-NixOS linux environment
# or macOS without nix-darwin.
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
      ../hm/home.nix
    ]
    ++ host.hm_modules;
}
