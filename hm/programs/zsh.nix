{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.zsh = {
    enable = true;
    autocd = true;
    dotDir = ".config/zsh";
    # builtin plugins.
    enableAutosuggestions = true;
    enableCompletion = true;
    syntaxHighlighting = {
        enable = true;
    };

    shellAliases = {
    };

    sessionVariables = {
      ISHELL = "zsh";
      PYENV_SHELL = "zsh";
    };

    # Most of these are the default values.
    history = {
      path = "${config.xdg.stateHome}/zsh/history";
      size = 10000;
      save = 50000;
      extended = true;
      share = true;
      ignoreDups = true;
      ignoreSpace = true;
      expireDuplicatesFirst = false;
    };

    historySubstringSearch = {
      enable = true;
      searchUpKey = ["^K" "^P"];
      searchDownKey = "^N";
    };

    # Extras to add to .zshenv
    envExtra = ''
    '';

    # Extras to add to .zshrc
    initExtra = ''
      bindkey -v
      autoload -U chpwd_recent_dirs cdr add-zsh-hook
      add-zsh-hook chpwd chpwd_recent_dirs
      autoload -U zmv
      autopair-init

      bindkey "^L" autosuggest-accept

      # NOTE: These might be declared by home-manager.
      # declare -A ZSH_HIGHLIGHT_STYLES
      # ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor root)

      # hooks not supported by home-manager
      eval "$(micromamba shell hook --shell=zsh)" 2&> /dev/null
    '';

    # Plugins not natively supported by home-manager.
    # These will git cloned and sourced, so there's little overhead.
    plugins = with pkgs; [
      {
        name = "zsh-autopair";
        src = fetchFromGitHub {
          owner = "hlissner";
          repo = "zsh-autopair";
          rev = "396c38a7468458ba29011f2ad4112e4fd35f78e6";
          sha256 = "PXHxPxFeoYXYMOC29YQKDdMnqTO0toyA7eJTSCV6PGE=";
        };
        file = "autopair.zsh";
      }
    ];
  };
}
