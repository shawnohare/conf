# Base shared system configuration that is host agnostic.
# env variables, shell aliases, and provide a common set of core system
# packages.
{
  config,
  lib,
  inputs,
  pkgs,
  home-manager,
  host,
  ...
}: {
  imports = [
  ];

  environment = {
    shells = [pkgs.zsh pkgs.nushell]; # Default shell
    variables = {
    };
    shellAliases = {
    };
    # Load variables set in /etc/environment.d
    extraInit = ''
      if [ -d /etc/environment.d ]; then
         set -a
          . /etc/environment.d/*
          set +a
      fi
    '';

    # TODO: Consider moving most of these to home-manager.
    systemPackages = with pkgs; [
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
      exa  # unmaintained!
      # eza  # maintained version of exa. Keep both in case of re-name.
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
    ];
  };

  fonts = {
    # Fonts
    fontDir.enable = true;
    fonts = [
      (pkgs.nerdfonts.override {
        fonts = [
          "JetBrainsMono"
        ];
      })
    ];
  };

  # does not appear to be included in nix-darwin
  # i18n.defaultLocale = "en_US.UTF-8";

  # use unstable nix so we can access flakes
  nix = {
    configureBuildUsers = true;
    nrBuildUsers = 32;
    package = pkgs.nixUnstable;

    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';
    settings = {
      sandbox = false;
      trusted-substituters = [];
      trusted-public-keys = [];
    };
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  programs = {
    zsh = {
      enable = true;
    };
  };

  services = {
    nix-daemon = {
      enable = true;
    };
  };

  users = {
    nix = {
    };
    users."${host.username}" = {
      # isNormalUser = true;
      name = "${host.username}";
      home = lib.mkDefault (
        if pkgs.stdenv.isDarwin
        then "/Users/${host.username}"
        else "/home/${host.username}"
      );
      shell = pkgs.zsh;
    };
  };
}
