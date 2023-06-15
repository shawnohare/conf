{
  pkgs,
  lib,
  config,
  host,
  ...
}: {
  # Let home-manager manage itself.
  imports = [
    ../programs/readline.nix
    ../programs/git.nix
    ../programs/starship.nix
    ../programs/exa.nix
    ../programs/zsh.nix
    ../programs/bash.nix
    ../programs/tmux.nix
  ];

  home = {
    username = lib.mkDefault "${host.username}";
    homeDirectory = lib.mkDefault (
      if pkgs.stdenv.isDarwin
      then "/Users/${config.home.username}"
      else "/home/${config.home.username}"
    );
    stateVersion = lib.mkDefault "${host.stateVersion}";

    # The home.packages option allows you to install Nix packages into your
    # environment.
    packages = [
      # # Adds the 'hello' command to your environment. It prints a friendly
      # # "Hello, world!" when run.
      pkgs.home-manager
      pkgs.hello

      # # It is sometimes useful to fine-tune packages, for example, by applying
      # # overrides. You can do that directly here, just don't forget the
      # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
      # # fonts?
      # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

      # # You can also create simple shell scripts directly inside your
      # # configuration. For example, this adds a command 'my-hello' to your
      # # environment:
      # (pkgs.writeShellScriptBin "my-hello" ''
      #   echo "Hello, ${config.home.username}!"
      # '')
    ];

    # Home Manager is pretty good at managing dotfiles. The primary way to manage
    # plain files is through 'home.file'.
    file = {
      # ".profile" set by bash.nix module
      # ".profile".source = ../etc/sh/env.sh;
      # ".bashrc".source = ../etc/bash/rc.bash;
      # ".bash_profile".source = ../etc/bash/profile.bash;
      ".config/" = {
        recursive = true;
        source = ../etc/config;
      };
      ".config/sh" = {
        recursive = true;
        source = ../etc/sh;
      };
      ".local/bin" = {
        recursive = true;
        source = ../bin;
      };
      ".local/bin/switch".source = ../../bin/switch;

      # # You can also set the file content immediately.
      # ".gradle/gradle.properties".text = ''
      #   org.gradle.console=verbose
      #   org.gradle.daemon.idletimeout=3600000
      # '';
    };

    # NOTE: The shell must be managed by home-manager for env vars and aliases
    # to be defined.
    sessionVariables = {
      # EDITOR = "emacs";
      _HM_MYVAR = 1;
      LANG = "en_US.UTF-8";
      # NIXPKGS_CONFIG="${config.xdg.configHome}/nixpkgs/config.nix";
      # SQITCH_USER_CONFIG="${config.xdg.configHome}/sqitch/config";
      # STASH_TARGET="${HOME}";
      CARGO_HOME = "${config.xdg.stateHome}/cargo";
      CLICOLOR = "1";
      DOOMDIR = "${config.xdg.configHome}/doom";
      EDITOR = "nvim";
      GOPATH = "${config.xdg.stateHome}/go";
      HOMEBREW_BOOTSNAP = 1;
      HOMEBREW_CELLAR = /opt/homebrew/Cellar;
      HOMEBREW_NO_ANALYTICS = 1;
      HOMEBREW_NO_AUTO_UPDATE = 1;
      HOMEBREW_PREFIX = /opt/homebrew;
      HOMEBREW_REPOSITORY = /opt/homebrew;
      IPYTHONDIR = "${config.xdg.configHome}/ipython";
      LESS = "-Mr";
      LESSHISTFILE = "${config.xdg.stateHome}/less/history";
      LISTLINKS = 1;
      LS_COLORS = "ExGxBxDxCxEgEdxbxgxcxd";
      MAMBARC = "${config.xdg.configHome}/mamba/config.yaml";
      MAMBA_ROOT_PREFIX = "${config.xdg.stateHome}/mamba";
      MANCOLOR = 1;
      MANPAGER = "nvim --clean +Man!";
      PAGER = "less";
      PIPX_HOME = "${config.xdg.stateHome}/pipx";
      POETRY_HOME = "${config.xdg.stateHome}/pypoetry";
      POETRY_VIRTUALENVS_PATH = "${config.xdg.stateHome}/pypoetry/envs";
      PYENV = "${config.xdg.stateHome}/pyenv/bin/pyenv";
      PYENV_ROOT = "${config.xdg.stateHome}/pyenv";
      PYENV_VIRTUALENV_DISABLE_PROMPT = 1;
      PYSPARK_DRIVER_PYTHON = "ipython";
      RUSTUP_HOME = "${config.xdg.stateHome}/rustup";
      SCREENRC = "${config.xdg.configHome}/screen/screenrc";
      SPACEMACSDIR = "${config.xdg.configHome}/spacemacs";
      STACK_ROOT = "${config.xdg.stateHome}/stack";
      TMUX_PLUGIN_MANAGER_PATH = "${config.xdg.stateHome}/tmux/plugins/";
      VISUAL = "nvim";
      WEECHAT_HOME = "${config.xdg.configHome}/weechat";
    };

    shellAliases = {
      ".." = "cd ..";
      "..." = "cd ../..";
      "..2" = "cd ../..";
      "...." = "cd ../../..";
      "..3" = "cd ../../..";
      "....." = "cd ../../../..";
      "..4" = "cd ../../../..";
      dev = "nix develop";
      mamba = "micromamba";
      conda = "micromamba";
    };
  };

  # Defaults to simply enable without much configuration.
  programs = {
    home-manager.enable = true;
    zoxide.enable = true;
    htop.enable = true;
    bottom.enable = true;
  };
  xdg.enable = true;
}
