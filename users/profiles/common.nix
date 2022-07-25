# Cross-platform home-manager program configurations.
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
