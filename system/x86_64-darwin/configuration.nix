# Intel macOS system configuration.
{
  config,
  lib,
  inputs,
  pkgs,
  home-manager,
  user,
  ...
}: {
  # Import cross-platform system configuration.
  imports = [
    ../common/configuration.nix
    ../macos/configuration.nix
  ];
}
