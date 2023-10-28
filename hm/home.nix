{
  pkgs,
  lib,
  config,
  host,
  ...
}: let
  homebrew_prefix = "/opt/homebrew";
  local_bin = "$HOME/.local/bin";
in {
  # Let home-manager manage itself.
  imports = [
    programs/readline.nix
    programs/git.nix
    programs/starship.nix
    # programs/exa.nix  # TODO: not maintained, remove when ready.
    programs/eza.nix  # TODO: Might need newer hm version. eza not found.
    programs/zsh.nix
    programs/bash.nix
    programs/tmux.nix
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
    # home environment. NOTE: do not add home-manager to home.packages or
    # system packages to avoid collisions.
    packages = with pkgs; [
      # # Adds the 'hello' command to your environment. It prints a friendly
      # # "Hello, world!" when run.
      hello

      alejandra
      awscli2
      bash
      bandwhich
      bat  # cat clone
      bottom  # not top
      cachix
      # coreutils-prefixed
      ctags
      curl
      delta # diff
      devbox
      direnv
      du-dust # du + rust = dust
      # entr
      # NOTE: eza seems to be added in 23.11?
      # exa  # unmaintained!
      eza  # maintained version of exa. Keep both in case of re-name.
      fd
      fastmod
      git
      glow
      htop
      hyperfine # benchmarking
      jq
      miller
      moreutils
      mosh
      # micromamba
      # neovim  # NOTE: We like to use newer versions.
      ncurses
      nushell
      pandoc
      procs # ps replacement
      q-text-as-data
      ripgrep
      rustup  # TODO: Manually install this toolchain?
      shellcheck
      sd # simple sed
      starship
      tealdeer
      tectonic
      tmux
      tokei
      uutils-coreutils
      wget
      zoxide # like z
      zsh

      # # It is sometimes useful to fine-tune packages, for example, by applying
      # # overrides. You can do that directly here, just don't forget the
      # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
      # # fonts?
      (nerdfonts.override {
        fonts = [
          "JetBrainsMono"
        ];
      })

      # # You can also create simple shell scripts directly inside your
      # # configuration. For example, this adds a command 'my-hello' to your
      # # environment:
      # (pkgs.writeShellScriptBin "my-hello" ''
      #   echo "Hello, ${config.home.username}!"
      # '')
    ];

    # Home Manager can symlink config files. The primary way to manage
    # plain files is through 'home.file'.
    # The actual symlinks point to read-only files,
    # TODO: This makes tinkering a bit of a pain. Consider
    # managing non-hm configurations manually.
    file = {
      # ".config/" = {
      #   recursive = true;
      #   source = ./etc/config;
      # };
      ".config/ipython/profile_default/ipython_config.py".source = ./etc/ipython/config.py;
      ".local/bin" = {
        recursive = true;
        source = ./bin;
      };
      ".local/bin/switch".source = ../bin/switch;

      # # You can also set the file content immediately.
      # ".gradle/gradle.properties".text = ''
      #   org.gradle.console=verbose
      #   org.gradle.daemon.idletimeout=3600000
      # '';
    };

    # NOTE: The shell must be managed by home-manager for env vars and aliases
    # to be available.
    sessionVariables = {
      LANG = "en_US.UTF-8";
      CARGO_HOME = "${config.xdg.stateHome}/cargo";
      CLICOLOR = "1";
      DOOMDIR = "${config.xdg.configHome}/doom";
      EDITOR = "nvim";
      GOPATH = "${config.xdg.stateHome}/go";
      HOMEBREW_BOOTSNAP = 1;
      HOMEBREW_CELLAR = /opt/homebrew/Cellar;
      HOMEBREW_NO_ANALYTICS = 1;
      # HOMEBREW_NO_AUTO_UPDATE = 1;
      HOMEBREW_PREFIX = /opt/homebrew;
      HOMEBREW_REPOSITORY = /opt/homebrew;
      IPYTHONDIR = "${config.xdg.configHome}/ipython";
      LESS = "-Mr";
      LESSHISTFILE = "${config.xdg.stateHome}/less/history";
      LISTLINKS = 1;
      # LS_COLORS handled by dircolors module.
      # LS_COLORS = "ExGxBxDxCxEgEdxbxgxcxd";
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
      # home-manager handles plugins directly.
      # TMUX_PLUGIN_MANAGER_PATH = "${config.xdg.stateHome}/tmux/plugins/";
      VISUAL = "nvim";
      WEECHAT_HOME = "${config.xdg.configHome}/weechat";
      PATH = "${local_bin}:$PATH:${homebrew_prefix}/bin:${homebrew_prefix}/sbin:${config.xdg.stateHome}/cargo/bin:${config.xdg.stateHome}/go/bin";
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
  # More detailed configurations live in ./programs
  programs = {
    bottom.enable = true;
    dircolors.enable = true;
    home-manager.enable = true;
    htop.enable = true;
    zoxide.enable = true;
  };

  xdg.enable = true;
  fonts.fontconfig.enable = true;
}
