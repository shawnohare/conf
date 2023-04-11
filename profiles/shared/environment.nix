# Common environment set up
# - shell aliases
# - env vars
# - system packages
# Many of the aliases and such will not translate to development shells.
{
  self,
  config,
  lib,
  inputs,
  pkgs,
  home-manager,
  ...
}: {
  environment = {
    shells = with pkgs; [zsh]; # Default shell
    variables = {
      LANG = "en_US.UTF-8";
      EDITOR = "nvim";
      VISUAL = "nvim";
      PAGER = "less";
      MANPAGER = "nvim --clean +Man!";
      CLICOLOR = "1";
    };
    shellAliases = {
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      "....." = "cd ../../../..";
      dev = "nix develop";
      ls = "exa --icons --color-scale";
      la = "exa --long --all --icons --color-scale --group --header";
      lg = "exa --long --all --icons --color-scale --grid --group --header";
    };
    # Load variables set in /etc/environment.d
    extraInit = ''
      if [ -d /etc/environment.d ]; then
         set -a
          . /etc/environment.d/*
          set +a
      fi
    '';
    systemPackages = with pkgs; [
      awscli2
      bash
      bottom
      # coreutils-prefixed
      ctags
      curl
      direnv
      # entr
      exa
      fd
      fastmod
      git
      glow
      htop
      jq
      miller
      moreutils
      mosh
      # micromamba
      # NOTE: We tend to use recent versions of neovim and install directly.
      # neovim
      nushell
      ripgrep
      rustup
      q-text-as-data
      shellcheck
      tectonic
      tmux
      uutils-coreutils
      wget
      zsh
    ];
  };

}
