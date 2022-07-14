#  Home-manager configuration for macs.
#
#  flake.nix
#   ├─ ./darwin
#   │   ├─ ./default.nix
#   │   └─ ./home.nix *
#   └─ ./modules
#       └─ ./programs
#           └─ ./alacritty.nix
#

{ config, lib, nixpkgs, pkgs, user, home, ... }:

{
  # imports =
  #   [
  #     ../modules/programs/alacritty.nix
  #   ];

  # Specific user  packages for macs.
  home = {
    username = "${user}";
    # username = "shawn";
    # username = "user";
    homeDirectory = "/Users/${user}";
    # homeDirectory = "${home}";
    packages = with pkgs; [
      pfetch
    ];
    stateVersion = "22.05";
    # stateVersion = nixpkgs.lib.version;

  };

  programs = {
    # Let home-manager manage itself.
    home-manager = {
      enable = true;
    };
    alacritty = {
      # Terminal Emulator
      enable = false;
    };
    htop = {
      enable = true;
      settings = {
        show_program_path = true;
      };
    };
    zsh = {
      # Post installation script is run in configuration.nix to make it default shell
      enable = false;
      enableAutosuggestions = true; # Auto suggest options and highlights syntact, searches in history for options
      enableSyntaxHighlighting = true;
      history.size = 10000;

      # oh-my-zsh = {                               # Extra plugins for zsh
      #   enable = true;
      #   plugins = [ "git" ];
      #   custom = "$HOME/.config/zsh_nix/custom";
      #

      # initExtra = ''
      #   # Spaceship
      #   source ${pkgs.spaceship-prompt}/share/zsh/site-functions/prompt_spaceship_setup
      #   autoload -U promptinit; promptinit
      #   pfetch
      # '';                                         # Zsh theme
    };
    neovim = {
      enable = false;
      viAlias = true;
      vimAlias = true;

      # NOTE: Currently manage vim packages via packer
      # and lua configurations.
      # plugins = with pkgs.vimPlugins; [

      #   # Syntax
      #   vim-nix
      #   vim-markdown

      #   # Quality of life
      #   vim-lastplace                             # Opens document where you left it
      #   auto-pairs                                # Print double quotes/brackets/etc.
      #   vim-gitgutter                             # See uncommitted changes of file :GitGutterEnable

      #   # File Tree
      #   nerdtree                                  # File Manager - set in extraConfig to F6

      #   # Customization
      #   wombat256-vim                             # Color scheme for lightline
      #   srcery-vim                                # Color scheme for text

      #   lightline-vim                             # Info bar at bottom
      #   indent-blankline-nvim                     # Indentation lines
      # ];

      # extraConfig = ''
      #   syntax enable                             " Syntax highlighting
      #   colorscheme srcery                        " Color scheme text

      #   let g:lightline = {
      #     \ 'colorscheme': 'wombat',
      #     \ }                                     " Color scheme lightline

      #   highlight Comment cterm=italic gui=italic " Comments become italic
      #   hi Normal guibg=NONE ctermbg=NONE         " Remove background, better for personal theme

      #   set number                                " Set numbers

      #   nmap <F6> :NERDTreeToggle<CR>             " F6 opens NERDTree
      # '';
    };
  };
}
