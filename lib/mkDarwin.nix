# This function creates a macOS system based on our setup for a
# particular architecture and user.
{
  inputs,
  darwin,
  home-manager,
  determinate,
  target,
  ...
}:
darwin.lib.darwinSystem rec {
  system = target.host.system;
  specialArgs = {
    inherit inputs system target;
  };

  modules = [
    # Apply our overlays. Overlays are keyed by system type so we have
    # to go through and apply our system type. We do this first so
    # the overlays are available globally.
    # { nixpkgs.overlays = overlays; }
    # ../hardware/${name}.nix
    ../host/${target.host.config}
    # WARNING: Do not use home-manager switch if including as a nix-darwin module.
    home-manager.darwinModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = {
          inherit target;
        };
        users."${target.user.name}" = import ../home/${target.home.config};
      };
    }
    # TODO: See if determine is useful for non-enterprise use?
    # determinate.darwinModules.default
  ];
}
