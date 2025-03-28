{ pkgs, lib, config, ... }:

let
  cfg = config.gaming_pkgs;
in
{
  options.gaming_pkgs = with lib; {
    enable = mkEnableOption "enables gaming packages";
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
          protonup
          lutris
          cartridges
        ];

        macPackages = [
        ];

        wslPackages = [
        ];

        globalPackages = [
        ];

      in lib.optionals cfg.system.linux linuxPackages
         ++ lib.optionals cfg.system.mac macPackages
         ++ lib.optionals cfg.system.wsl wslPackages
         ++ globalPackages;
  };
}

