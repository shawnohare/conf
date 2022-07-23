{pkgs, ...}: {
  users.users.shawn = {
    # isNormalUser = true;
    home = "/Users/shawn";
    # extraGroups = ["wheel"];
    shell = pkgs.fish;
  };

  # nixpkgs.overlays = import ../../lib/overlays.nix ++ [
  #   (import ./vim.nix)
  # ];
}
