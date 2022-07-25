# Base shared system configuration that is host agnostic.
# env variables, shell aliases, and provide a common set of core system
# packages.
{
  config,
  lib,
  inputs,
  pkgs,
  home-manager,
  ...
}: {
  imports = [
    ./environment.nix
  ];


  fonts = {
    # Fonts
    fontDir.enable = true;
    fonts = with pkgs; [
      (pkgs.nerdfonts.override {
        fonts = [
          "JetBrainsMono"
        ];
      })
    ];
  };

  # does not appear to be included in nix-darwin
  # i18n.defaultLocale = "en_US.UTF-8";

  # use unstable nix so we can access flakes
  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';
    useSandbox = false;
    # sandboxPaths = ["/private/tmp" "/private/var/tmp" "/usr/bin/env"];
    binaryCachePublicKeys = [];
    trustedBinaryCaches = [];
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  programs = {
    zsh = {
      enable = true;
    };
  };

  services = {
    nix-daemon = {
      enable = true;
    };
  };

  users = {
    nix = {
      configureBuildUsers = true;
      nrBuildUsers = 32;
    };
  };
}
