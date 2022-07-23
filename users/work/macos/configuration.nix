# work user macOS level configurations.
{
  config,
  lib,
  inputs,
  pkgs,
  home-manager,
  user,
  ...
}: {
  imports = [
    ../../macos/configuration.nix
  ];
}
