# Base shared system configuration that is host agnostic.
# env variables, shell aliases, and provide a common set of core system
# packages.
{
  config,
  lib,
  inputs,
  pkgs,
  home-manager,
  target,
  ...
}: {
  imports = [
  ];

  environment = {
    shells = [pkgs.zsh pkgs.nushell]; # Default shell
    variables = {
    };
    shellAliases = {
    };
    # Load variables set in /etc/environment.d
    extraInit = ''
      if [ -d /etc/environment.d ]; then
         set -a
          . /etc/environment.d/*
          set +a
      fi
    '';

    # TODO: Consider moving most of these to home-manager.
    systemPackages = with pkgs; [
    ];
  };

  # does not appear to be included in nix-darwin
  # i18n.defaultLocale = "en_US.UTF-8";

  # use unstable nix so we can access flakes
  nix = {
    # configureBuildUsers = true;
    # nrBuildUsers = 32;
    package = pkgs.nixVersions.latest;
    gc = {
      automatic = true;
      interval.Day = 7; #Hours, minutes
      options = "--delete-older-than 7d";
    };

    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';
    settings = {
      sandbox = false;
      trusted-substituters = [];
      trusted-public-keys = [];
    };
  };

  nixpkgs.config.allowUnfree = true;

  programs.zsh.enable = true;

  # nix-darwin manages nix-daemon when nix.enable is on
  # services.nix-daemon.enable = true;

  users = {
    nix = {
    };
    users."${target.user.name}" = {
      # isNormalUser = true;
      name = "${target.user.name}";
      home = lib.mkDefault (
        if pkgs.stdenv.isDarwin
        then "/Users/${target.user.name}"
        else "/home/${target.user.name}"
      );
      shell = pkgs.zsh;
    };
  };
}
