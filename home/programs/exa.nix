{
  config,
  lib,
  nixpkgs,
  pkgs,
  ...
}: {
  # Sets an alias exa -> exa (extra Options) and ls - (exa)
  programs.exa = {
    enable = true;
    enableAliases = true;
    extraOptions = [
      "--all"
      "--header"
      "--group-directories-first"
      # "--color-scale"
      "--long"
      "--classify"
      # "--extended"
    ];
    icons = true;
    git = false;
  };
}
