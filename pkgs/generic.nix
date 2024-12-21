{ pkgs, lib, config, ... }:

let
  cfg = config.generic_pkgs;
in
{
  options.generic_pkgs = with lib; {
    enable = mkEnableOption "enables generic packages";
    system = {
      mac = mkEnableOption "enables macOS system configuration";
      linux = mkEnableOption "enables Linux system configuration";
      wsl = mkEnableOption "enables WSL system configuration";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs;
      let
        linuxPackages = [
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
        ];

        macPackages = [
          iina
          raycast
          rectangle
          hidden-bar
          alt-tab-macos
          unar
        ];

        wslPackages = [
        ];

        globalPackages = [
          warp-terminal
          ani-cli
          hyfetch
          youtube-music
          vesktop
          google-chrome
          home-manager
          eza
          fd
          jq
        ];

      in lib.optionals cfg.system.linux linuxPackages
         ++ lib.optionals cfg.system.mac macPackages
         ++ lib.optionals cfg.system.wsl wslPackages
         ++ globalPackages;
  };
}

