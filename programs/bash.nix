{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.bash = {
    enable = true;
    enableCompletion = true;

    historyFile = "${config.xdg.stateHome}/bash/history";

    sessionVariables = {
      ISHELL = "bash";
      PYENV_SHELL = "bash";
    };

    shellOptions = [
      "autocd"
      "cdspell"
      "checkhash"
      "checkjobs"
      "checkwinsize"
      "cmdhist"
      "dirspell"
      "extglob"
      "globstar"
      "histappend"
      "lithist"
      "no_empty_cmd_completion"
      "nocaseglob"
      "xpg_echo"
    ];

    # TODO: Set path properly?
    initExtra = ''
      # source "$HOME/.config/sh/path.sh"

      # hooks not supported by home-manager
      eval "$(micromamba shell hook --shell=bash)" 2&> /dev/null
    '';
  };
}
