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
  ];

  # macos specific aliases. These could be put in a common file and
  # have a switch based on system type, but for now we make it explicit.
  environment = {
    shellAliases = {
      # nrb = "darwin-rebuild switch --flake";
    };
  };

  homebrew = {
    enable = true;
    # onActivation.autoUpdate = False;
    # onActivation.cleanup = "zap";
    # onActivation.upgrade = False;
    brews = [
    ];
    casks = [
      "firefox"
      "hammerspoon"
      "jetbrains-toolbox"
      "linearmouse"
      "rectangle"
      "wezterm"
      "warp"
    ];
    taps = [];
  };

  # macOS system defaults configuration that normally occurr through UI.
  security = {
    pam.enableSudoTouchIdAuth = true;
  };
  system = {
    defaults = {
      NSGlobalDomain = {
        AppleKeyboardUIMode = 3;
        ApplePressAndHoldEnabled = false;
        InitialKeyRepeat = 15;
        KeyRepeat = 2;
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
        autohide-delay = 0.0;
        autohide-time-modifier = 0.0;
        mru-spaces = false;
        orientation = "bottom";
        showhidden = true;
        tilesize = 64;
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
      # remapCapsLockToControl = true;
    };
  };
}
