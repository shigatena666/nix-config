{
  pkgs,
  inputs,
  outputs,
  userConfig,
  ...
}: 
let
  common = { 
    enable = true; 
    system.mac = true; 
  };
in
{
  # Add nix-homebrew configuration
  nix-homebrew = {
    enable = true;
    enableRosetta = true;
    user = "${userConfig.name}";
    autoMigrate = true;
  };

  # Nixpkgs configuration
  nixpkgs = {
    overlays = [
      outputs.overlays.stable-packages
    ];

    config = {
      allowUnfree = true;
    };
  };

  # Nix settings
  nix.settings = {
    experimental-features = "nix-command flakes";
  };

  nix.optimise.automatic = true;

  nix.package = pkgs.nix;

  # Enable Nix daemon
  services.nix-daemon.enable = true;

  # User configuration
  users.users.${userConfig.name} = {
    name = "${userConfig.name}";
    home = "/Users/${userConfig.name}";
  };

  # Add ability to use TouchID for sudo
  security.pam.enableSudoTouchIdAuth = true;

  # System settings
  system = {
    defaults = {
      ".GlobalPreferences" = {
        "com.apple.mouse.scaling" = -1.0;
      };
      NSGlobalDomain = {
        AppleInterfaceStyle = "Dark";
        ApplePressAndHoldEnabled = false;
        AppleShowAllExtensions = false;
        KeyRepeat = 2;
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticDashSubstitutionEnabled = false;
        NSAutomaticQuoteSubstitutionEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
        NSAutomaticWindowAnimationsEnabled = false;
        NSDocumentSaveNewDocumentsToCloud = false;
        NSNavPanelExpandedStateForSaveMode = true;
        PMPrintingExpandedStateForPrint = true;
      };
      LaunchServices = {
        LSQuarantine = false;
      };
      trackpad = {
        TrackpadRightClick = true;
        TrackpadThreeFingerDrag = true;
        Clicking = true;
      };
      finder = {
        AppleShowAllFiles = false;
        CreateDesktop = false;
        FXDefaultSearchScope = "SCcf";
        FXEnableExtensionChangeWarning = false;
        FXPreferredViewStyle = "Nlsv";
        QuitMenuItem = true;
        ShowPathbar = true;
        ShowStatusBar = true;
        _FXShowPosixPathInTitle = false;
        _FXSortFoldersFirst = true;
      };
      dock = {
        autohide = true;
        expose-animation-duration = 0.15;
        show-recents = false;
        showhidden = true;
        persistent-apps = [
          "/Applications/Nix Apps/Google Chrome.app"
          "/Applications/Nix Apps/Warp.app"
          "/Applications/Nix Apps/Visual Studio Code.app"
          "/Applications/Nix Apps/Vesktop.app"
          "/Applications/Nix Apps/Youtube Music.app"
        ];
        tilesize = 50;
        wvous-bl-corner = 1;
        wvous-br-corner = 1;
        wvous-tl-corner = 1;
        wvous-tr-corner = 1;
      };
      screencapture = {
        location = "/Users/${userConfig.name}/Downloads/temp";
        type = "png";
        disable-shadow = true;
      };
    };
    keyboard = {
      enableKeyMapping = true;
      # swapLeftCtrlAndFn = true;
      # Remap §± to ~
      userKeyMapping = [
        {
          HIDKeyboardModifierMappingDst = 30064771125;
          HIDKeyboardModifierMappingSrc = 30064771172;
        }
      ];
    };
  };

  # System packages
  gaming_pkgs = common;
  generic_pkgs = common;
  messengers_pkgs = common;
  networking_pkgs = common;
  pentesting_pkgs = common;
  programming_pkgs = common;
  security_pkgs = common;
  storage_pkgs = common;
  theming_pkgs = common;
  virtualization_pkgs = common;

  # Activate Tailscale
  services.tailscale.enable = true;

  # Fonts configuration
  fonts.packages = with pkgs; [
    roboto
  ] ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts); 

  # Homebrew packages
    homebrew = {
    enable = true;
    casks = [
      "proton-drive"
      "proton-mail"
      "proton-pass"
      "protonvpn"
    ];
    taps = [
    ];
    onActivation.cleanup = "zap";
  };

  # Used for backwards compatibility, please read the changelog before changing.
  system.stateVersion = 5;
}
