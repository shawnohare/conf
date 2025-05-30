{
  config,
  lib,
  nixpkgs,
  pkgs,
  ...
}: {
  # Sets an alias eza -> eza (extra Options) and ls - (eza)
  programs.eza = {
    enable = true;
    extraOptions = [
      "--all"
      "--header"
      "--group-directories-first"
      # "--color-scale"
      "--long"
      "--classify"
      # "--extended"
    ];
    icons = "auto";
    git = false;
  };
}
