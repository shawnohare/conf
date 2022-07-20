# This function creates a macOS system based on our setup for a
# particular architecture and user.
# TODO: How to incorporate profiles. Too premature for this?
# FIXME: To handle non nixOS systems we probably do have to split
# user configs into
# base
# work
# shawn
#
#
#
name: { darwin, nixpkgs, home-manager, system, user, overlays }:

darwin.lib.darwinSystem rec {
  inherit system;

  # users.users.${user.name} = {
  #   home = "/Users/${user}";
  #   shell = pkgs.zsh;
  # };
  users.users.me = {
    home = "/Users/user";
    shell = pkgs.zsh;
  };

  modules = [
    # Apply our overlays. Overlays are keyed by system type so we have
    # to go through and apply our system type. We do this first so
    # the overlays are available globally.
    # { nixpkgs.overlays = overlays; }

    # ../hardware/${name}.nix
    # ../hosts/macos/${name}.nix
    # mh sets user specific system settings here.
    # For our needs we could just
    # ../users/${user}/configuration.nix
    # System config for user.
    # ../users/${user}/macos.nix
    home-manager.darwinModules.home-manager {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        # TODO: Can we use generic name?
        # users.main = import ../users/${user}/home.nix;
        # extraSpecialArgs = {inherit user;};
        # users.main = import ../users/${user}/home.nix;
        # TODO: Can we just
        # NOTE: home-manager.users maps system users to user configurations.
        # The
        users.me = {
            home = {
                # username = "${user}";
                # homeDirectory = "/Users/${user}";
                stateVersion = "22.05";
            };
        };

      };

      # We expose some extra arguments so that our modules can parameterize
      # better based on these values.
      {
        config._module.args = {
          currentSystemName = name;
          currentSystem = system;
        };
      }
  ];
}
