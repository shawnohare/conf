{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.readline = {
    enable = true;
    bindings = {
      "\C-k" = "history-substring-search-backward";
      "\C-j" = "history-substring-search-forward";
      "\C-h" = "backward-kill-word";
    };
    variables = {
      bell-style = "none";
      editing-mode = "vi";
    };
    includeSystemConfig = true;
    extraConfig = ''
    '';
  };
}
