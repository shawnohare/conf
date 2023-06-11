# Cross-platform home-manager configuration.
{
  config,
  nixpkgs,
  pkgs,
  user,
  ...
}: {
  # Let home-manager manage itself.
  programs = {
    home-manager = {
      enable = true;
    };
  };
}
