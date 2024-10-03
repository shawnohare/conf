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
      styles = {
        alias = "fg=blue,italic";
        arg0 = "fg=yellow";
        assign = "none";
        # back-dollar-quoted-argument = "none"
        # back-double-quoted-argument = "green"
        # back-quoted-argument-delimiter = "none"
        # back-quoted-argument-unclosed = "fg=red"
        # back-quoted-argument = "none"
        bracket-error = "fg=red,bold";
        bracket-level-1 = "fg=white,bold";
        bracket-level-2 = "fg=yellow,bold";
        bracket-level-3 = "fg=green,bold";
        bracket-level-4 = "fg=magenta,bold";
        builtin = "fg=yellow,italic";
        # command-substitution-delimiter-quoted = "none"
        # command-substitution-delimiter-unquoted = "none"
        # command-substitution-delimiter = "none"
        # command-substitution-quoted = "none"
        # command-substitution-unquoted = "none"
        # command-substitution = "none"
        command = "fg=magenta,italic";
        # commandseparator = "none"
        comment = "fg=gray";
        cursor-matchingbracket = "fg=black,bg=red";
        # cursor = "bg=black"
        dollar-double-quoted-argument = "fg=cyan";
        dollar-quoted-argument-unclosed = "fg=red";
        dollar-quoted-argument = "fg=cyan";
        double-hyphen-option = "fg=green";
        double-quoted-argument-unclosed = "fg=red";
        double-quoted-argument = "fg=cyan";
        function = "fg=blue";
        globbing = "fg=red";
        # hashed-command = "none"
        history-expansion = "none";
        # named-fd = "none"
        path = "fg=blue,bold";
        # path_pathseparator = "fg=yellow"
        # path_prefix = "none"
        # path_prefix_pathseparator = "none"
        # precommand = "fg=yellow"
        # process-substitution-delimiter = "none"
        # process-substitution = "none"
        # rc-quote = "none"
        redirection = "fg=red";
        reserved-word = "fg=red,italic";
        single-hyphen-option = "fg=green";
        single-quoted-argument-unclosed = "fg=red";
        single-quoted-argument = "fg=green";
        # suffix-alias = "yellow"
        # unknown-token = "none"
      };
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
      searchUpKey = ["^[[A" "^K" "^P"];
      searchDownKey = ["^[[B" "^N"];
    };

    # Extras to add to .zshenv
    envExtra = ''
      source "~/.zshenv.local" 2&> /dev/null
    '';

    # Extras to add to .zshrc
    initExtra = ''
      bindkey -v
      autoload -U chpwd_recent_dirs cdr add-zsh-hook
      add-zsh-hook chpwd chpwd_recent_dirs
      autoload -U zmv
      autopair-init


      # Align with warp.
      bindkey "^F" autosuggest-accept

      # hooks not supported by home-manager
      # awscli completions according to docs. It does not seem
      # these are available by default or via carapace as of 2024-05-01.
      autoload bashcompinit && bashcompinit
      complete -C aws_completer aws
      eval "$(devbox global shellenv --init-hook)" 2&> /dev/null
      eval "$(micromamba shell hook --shell=zsh)" 2&> /dev/null
    '';

    # Plugins not natively supported by home-manager.
    # These will git cloned and sourced, so there is little overhead.
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
