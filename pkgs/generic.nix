{ pkgs, lib, config, ... }:

{
  options.generic = {
    enable = lib.mkEnableOption "enables generic module";
    system = {
      mac = lib.mkEnableOption "enables mac system configuration";
      linux = lib.mkEnableOption "enables linux system configuration";
      windows = lib.mkEnableOption "enables windows system configuration";
    };
  };

  config = lib.mkIf config.generic.enable {
    environment.systemPackages = with pkgs;
      [
        warp-terminal
        ani-cli
        hyfetch
        youtube-music
        vesktop
        google-chrome
        home-manager
      ]
      ++ lib.optionals config.generic.system.linux [
        dconf2nix
        dconf-editor
        pavucontrol
        efibootmgr
        gtop
        gnumake
        rofi
        pulseaudio
        rust-traverse
        nautilus
        eza
      ]
      ++ lib.optionals config.generic.system.mac [
        iina
        raycast
        rectangle
        hidden-bar
        alt-tab-macos
        unar
      ];
    };
  }