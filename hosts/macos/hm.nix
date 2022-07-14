#  Home-manager configuration for macs.
#
#  flake.nix
#   ├─ ./macos
#   │   ├─ ./default.nix
#   │   └─ ./home.nix *
#   └─ ./modules
#       └─ ./programs
#           └─ ./alacritty.nix
#

{ config, nixpkgs, pkgs, user, ... }:

{
  # Should this go more properly in configuration.nix?
  home-manager.darwinModules.home-manager {             # Home-Manager module that is used
  home-manager =
    {
      useGlobalPkgs = true;
      useUserPackages = true;
      extraSpecialArgs = {
        user = "${user}";
      };
      users.${user} = { }
        };
    }
      # imports =
      #   [
      #     ../modules/programs/alacritty.nix
      #   ];

      # Specific user packages for macs.
      home = {
  username = "${user}";
  homeDirectory = "/Users/${user}";
  packages = with pkgs; [
  ];
  stateVersion = "22.05";
  # stateVersion = nixpkgs.lib.version;

};

# TODO: Our configurations for core programs should
# generally be cross-platform
# instead?
programs = {
# Let home-manager manage itself.
home-manager = {
enable = true;
};
alacritty = {                                 # Terminal Emulator
enable = false;
};
htop = {
enable = true;
settings = {
show_program_path = true;
};
};
zsh = {                                       # Post installation script is run in configuration.nix to make it default shell
enable = false;
enableAutosuggestions = true;               # Auto suggest options and highlights syntact, searches in history for options
enableSyntaxHighlighting = true;
history.size = 10000;


# We use starship
# initExtra = ''
#   pfetch
# '';                                         # Zsh theme
};
neovim = {
enable = false;
# viAlias = true;
vimAlias = true;

# NOTE: Currently manage vim packages via packer
# and lua configurations. This might be difficult to migrate, but
# there appears to be some folk working on pushing lua-based neovim
# configs more fully into nix.
# plugins = with pkgs.vimPlugins; [
# ];

# extraConfig = ''
# '';
};
};
}
