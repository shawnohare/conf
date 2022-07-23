# shared macos user-specific home-manager configuration.
{
  config,
  pkgs,
  lib,
  home-manager,
  user,
  ...
}: {
  imports = [
    ../profiles/common.nix
  ];

  home = {
    username = "${user.name}";
    homeDirectory = "/Users/${user.name}";
    stateVersion = "22.05";
  };
}
