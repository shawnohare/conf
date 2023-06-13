# This function creates a macOS system based on our setup for a
# particular architecture and user.
{
  inputs,
  darwin,
  nixpkgs,
  home-manager,
  system,
  username,
  overlays,
  ...
}:
darwin.lib.darwinSystem rec {
  inherit system;
  specialArgs = {
    inherit username inputs;
  };

  modules = [
    # Apply our overlays. Overlays are keyed by system type so we have
    # to go through and apply our system type. We do this first so
    # the overlays are available globally.
    # { nixpkgs.overlays = overlays; }

    # ../hardware/${name}.nix
    ../system/${system}/configuration.nix
    ../profiles/macos/configuration.nix
    # ../users/common/configuration.nix

    home-manager.darwinModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = {
          inherit username;
        };
        users."${username}" = import ../hm/common/home.nix;
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
