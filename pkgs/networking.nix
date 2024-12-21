{ pkgs, lib, config, ... }:

let
  cfg = config.networking;
in
{
  options.networking = with lib; {
    enable = mkEnableOption "enables networking module";
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
        ];

        wslPackages = [
        ];

        globalPackages = [
          tailscale
          speedtest-go
          wget
        ];

      in lib.optionals cfg.system.linux linuxPackages
         ++ lib.optionals cfg.system.mac macPackages
         ++ lib.optionals cfg.system.wsl wslPackages
         ++ globalPackages;
  };
}

