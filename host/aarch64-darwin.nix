# Apple silicon macOS system configuration.
{
  config,
  lib,
  inputs,
  pkgs,
  home-manager,
  target,
  ...
}: {
  imports = [
    ./default.nix
    ./macos.nix
  ];
}
