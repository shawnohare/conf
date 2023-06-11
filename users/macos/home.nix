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
    ../home-manager/home.nix
  ];

  home = {
    username = "${user.name}";
    homeDirectory = "/Users/${user.name}";
    stateVersion = "23.05";
  };
}
