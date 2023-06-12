# This function creates a home-manager configuration.
# WARNING: Untested WIP
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
    extraSpecialArgs = { inherit inputs username; };
    modules = [
        ../hm/common/home.nix
        # Set username explicitly here.
        # {
        #     home = {
        #         username = "${username}";
        #         homeDirectory = "${homeDirectory}";
        #         stateVersion = "${stateVersion}";
        #
        #     };
        # }

    ] ++ additional_modules;
}

