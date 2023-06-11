# Cross-platform home-manager program configurations. This file represents
# the base home configuration.
{
  config,
  nixpkgs,
  pkgs,
  user,
  ...
}: {
  # Let home-manager manage itself.
  imports = [
    ./git.nix
    ./home-manager.nix
  ];
}
