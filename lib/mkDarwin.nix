# This function creates a macOS system based on our setup for a
# particular architecture and user.
{
  inputs,
  darwin,
  home-manager,
  host,
  ...
}:
darwin.lib.darwinSystem rec {
  system = host.system;
  specialArgs = {
    inherit inputs system host;
  };

  modules = [
    # Apply our overlays. Overlays are keyed by system type so we have
    # to go through and apply our system type. We do this first so
    # the overlays are available globally.
    # { nixpkgs.overlays = overlays; }

    # ../hardware/${name}.nix
    ../system/${host.system}/configuration.nix
    ../profiles/${host.profile}/configuration.nix
    home-manager.darwinModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = {
          inherit host;
        };
        # FIXME: It seems having a system and standalone version of
        # home-manager is incompatible?
        # users."${host.username}" = import ../hm/common/home.nix;
      };
    }

    # We expose some extra arguments so that our modules can parameterize
    # better based on these values.
    # {
    #   config._module.args = {
    #     currentSystemName = name;
    #     currentSystem = system;
    #   };
    # }
  ];
}
