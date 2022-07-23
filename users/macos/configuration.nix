# shared user-specific macos system configuration
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
    ../../hosts/macos/configuration.nix
  ];

  # NOTE: The user attribute name seems like it should match the actual
  # user name else home-manager complains.
  users = {
    users."${user.name}" = {
      # isNormalUser = true;
      name = "${user.name}";
      home = "/Users/${user.name}";
      shell = pkgs.zsh;
    };
  };
}
