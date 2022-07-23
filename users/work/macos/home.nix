# work profile macos specific home manager configurations.
{
  config,
  pkgs,
  lib,
  home-manager,
  user,
  ...
}: {
  imports = [
    ../../macos/home.nix
  ];
}
