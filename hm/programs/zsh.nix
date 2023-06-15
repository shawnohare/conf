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
    enableSyntaxHighlighting = true;

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

    # TODO: Better way to get these env vars in.
    envExtra = ''
      # source "$HOME/.profile"
    '';

    # TODO: Set path properly?
    initExtra = ''
      # source "$HOME/.config/sh/path.sh"
      bindkey -v
      autoload -U chpwd_recent_dirs cdr add-zsh-hook
      add-zsh-hook chpwd chpwd_recent_dirs
      autoload -U zmv
      autopair-init

      bindkey "^L" autosuggest-accept

      declare -A ZSH_HIGHLIGHT_STYLES
      ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor root)
      ZSH_HIGHLIGHT_STYLES[alias]='fg=blue'
      ZSH_HIGHLIGHT_STYLES[arg0]='none'
      ZSH_HIGHLIGHT_STYLES[assign]='none'
      ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]='none'
      ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='green'
      ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]='none'
      ZSH_HIGHLIGHT_STYLES[back-quoted-argument-unclosed]='fg=red'
      ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='none'
      ZSH_HIGHLIGHT_STYLES[bracket-error]='fg=red,bold'
      ZSH_HIGHLIGHT_STYLES[bracket-level-1]='fg=white,bold'
      ZSH_HIGHLIGHT_STYLES[bracket-level-2]='fg=yellow,bold'
      ZSH_HIGHLIGHT_STYLES[bracket-level-3]='fg=green,bold'
      ZSH_HIGHLIGHT_STYLES[bracket-level-4]='fg=magenta,bold'
      ZSH_HIGHLIGHT_STYLES[builtin]='fg=magenta,bold'
      ZSH_HIGHLIGHT_STYLES[command]='fg=yellow,bold'
      ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter-quoted]='none'
      ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter-unquoted]='none'
      ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]='none'
      ZSH_HIGHLIGHT_STYLES[command-substitution-quoted]='none'
      ZSH_HIGHLIGHT_STYLES[command-substitution-unquoted]='none'
      ZSH_HIGHLIGHT_STYLES[command-substitution]='none'
      ZSH_HIGHLIGHT_STYLES[command]='fg=magenta'
      ZSH_HIGHLIGHT_STYLES[commandseparator]='none'
      ZSH_HIGHLIGHT_STYLES[comment]='fg=gray'
      ZSH_HIGHLIGHT_STYLES[cursor-matchingbracket]='fg=red'
      ZSH_HIGHLIGHT_STYLES[cursor]='bg=black'
      ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=cyan'
      ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument-unclosed]='fg=red'
      ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=cyan'
      ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=yellow'
      ZSH_HIGHLIGHT_STYLES[double-quoted-argument-unclosed]='fg=red'
      ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=cyan'
      ZSH_HIGHLIGHT_STYLES[function]='fg=blue'
      ZSH_HIGHLIGHT_STYLES[globbing]='fg=yellow'
      ZSH_HIGHLIGHT_STYLES[hashed-command]='none'
      ZSH_HIGHLIGHT_STYLES[history-expansion]='none'
      ZSH_HIGHLIGHT_STYLES[named-fd]='none'
      ZSH_HIGHLIGHT_STYLES[path]='none'
      ZSH_HIGHLIGHT_STYLES[path_pathseparator]='fg=yellow'
      ZSH_HIGHLIGHT_STYLES[path_prefix]='none'
      ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]='none'
      ZSH_HIGHLIGHT_STYLES[precommand]='fg=yellow'
      ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]='none'
      ZSH_HIGHLIGHT_STYLES[process-substitution]='none'
      ZSH_HIGHLIGHT_STYLES[rc-quote]='none'
      ZSH_HIGHLIGHT_STYLES[redirection]='none'
      ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=magenta,bold'
      ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=yellow'
      ZSH_HIGHLIGHT_STYLES[single-quoted-argument-unclosed]='fg=red'
      ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=green'
      ZSH_HIGHLIGHT_STYLES[suffix-alias]='yellow'
      ZSH_HIGHLIGHT_STYLES[unknown-token]='none'

      HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='fg=red,bold'
      # HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=yellow,fg=black'
      HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='bg=red,fg=black,bold'
      # HISTORY_SUBSTRING_SEARCH_GLOBBING_FLAGS='i'
      # HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=""
      # HISTORY_SUBSTRING_SEARCH_FUZZY=""

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
