# Common macOS system configuration that is architecture independent.
{
  config,
  lib,
  inputs,
  pkgs,
  home-manager,
  user,
  ...
}: {
  # Import cross-platform system configuration.
  imports = [
    ../shared/configuration.nix
  ];

  environment = {
    shellAliases = {
      nrb = "darwin-rebuild switch --flake";
    };
  };

  homebrew = {
    enable = true;
    autoUpdate = false;
    cleanup = "zap";
    brews = [
    ];
    casks = [
      "jetbrains-toolbox"
      "alfred"
    ];
  };

  # macOS system defaults configuration that normally occurr through UI.
  system = {
    defaults = {
      NSGlobalDomain = {
        AppleKeyboardUIMode = 3;
        ApplePressAndHoldEnabled = false;
        InitialKeyRepeat = 10;
        KeyRepeat = 1;
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticDashSubstitutionEnabled = false;
        NSAutomaticPeriodSubstitutionEnabled = false;
        NSAutomaticQuoteSubstitutionEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
        NSNavPanelExpandedStateForSaveMode = true;
        NSNavPanelExpandedStateForSaveMode2 = true;
        _HIHideMenuBar = true;
      };
      dock = {
        autohide = true;
        mru-spaces = false;
        orientation = "left";
        showhidden = true;
      };
      finder = {
        AppleShowAllExtensions = true;
        AppleShowAllFiles = true;
        QuitMenuItem = true;
        FXEnableExtensionChangeWarning = false;
      };
      trackpad = {
        Clicking = true;
        TrackpadThreeFingerDrag = true;
      };
    };
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToControl = true;
    };
  };
}
