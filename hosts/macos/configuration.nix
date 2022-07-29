# Common macOS system configuration that is architecture independent.
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
  ];

}
