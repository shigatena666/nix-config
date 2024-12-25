{ pkgs, lib, config, ... }:

let
  cfg = config.networking_pkgs;
in
{
  options.networking_pkgs = with lib; {
    enable = mkEnableOption "enables networking packages";
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
          speedtest-go
          wget
          tailscale
        ];

      in lib.optionals cfg.system.linux linuxPackages
         ++ lib.optionals cfg.system.mac macPackages
         ++ lib.optionals cfg.system.wsl wslPackages
         ++ globalPackages;
  };
}

