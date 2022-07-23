# Common environment set up
# - shell aliases
# - env vars
# - system packages
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
      # g = "git log --pretty=color -32";
      # gb = "git branch";
      # gc = "git checkout";
      # gcb = "git checkout -B";
      # gd = "git diff --minimal --patch";
      # gf = "git fetch";
      # ga = "git log --pretty=color --all";
      # gg = "git log --pretty=color --graph";
      # gl = "git log --pretty=nocolor";
      # grh = "git reset --hard";
      # gs = "git status";
      # l = "ls -lh";
      ls = "exa --icons --color-scale";
      la = "exa --long --all --icons --color-scale";
      lg = "exa --long --all --icons --color-scale --grid";
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
      awscli
      bottom
      coreutils-prefixed
      ctags
      curl
      direnv
      # entr
      exa
      git
      htop
      jq
      mosh
      ripgrep
      shellcheck
      wget
    ];
  };

}
