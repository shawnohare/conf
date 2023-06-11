# Apple silicon macOS system configuration.
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
    ../shared/configuration.nix
    ../macos/configuration.nix
  ];

}
