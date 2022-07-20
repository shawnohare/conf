{pkgs, ...}: {
  users.users.work = {
    isNormalUser = true;
    home = "/Users/user";
    extraGroups = ["wheel"];
    shell = pkgs.fish;
  };

  # nixpkgs.overlays = import ../../lib/overlays.nix ++ [
  #   (import ./vim.nix)
  # ];
}
