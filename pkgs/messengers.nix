{ pkgs, lib, config, ... }:

let
  cfg = config.messengers_pkgs;
in
{
  options.messengers_pkgs = with lib; {
    enable = mkEnableOption "enables messengers packages";
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
          beeper
          zapzap
        ];

        macPackages = [
          whatsapp-for-mac
        ];

        wslPackages = [
        ];

        globalPackages = [
          signal-desktop
          vesktop
          slack
        ];

      in lib.optionals cfg.system.linux linuxPackages
         ++ lib.optionals cfg.system.mac macPackages
         ++ lib.optionals cfg.system.wsl wslPackages
         ++ globalPackages;
  };
}

