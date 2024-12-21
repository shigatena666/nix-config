{ pkgs, lib, config, ... }:

let
  cfg = config.messengers;
in
{
  options.messengers = with lib; {
    enable = mkEnableOption "enables messengers module";
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
        ];

        macPackages = [
          signal-desktop
          beeper
          zapzap
        ];

        wslPackages = [
        ];

        globalPackages = [
          vesktop
          slack
        ];

      in lib.optionals cfg.system.linux linuxPackages
         ++ lib.optionals cfg.system.mac macPackages
         ++ lib.optionals cfg.system.wsl wslPackages
         ++ globalPackages;
  };
}

