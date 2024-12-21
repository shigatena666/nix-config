{ pkgs, lib, config, ... }:

let
  cfg = config.storage_pkgs;
in
{
  options.storage_pkgs = with lib; {
    enable = mkEnableOption "enables storage packages";
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
          rclone
          mount
        ];

        macPackages = [
        ];

        wslPackages = [
        ]; 

        globalPackages = [
          sops
          gnupg
          openvpn
        ];

      in lib.optionals cfg.system.linux linuxPackages
        ++ lib.optionals cfg.system.mac macPackages
        ++ lib.optionals cfg.system.wsl wslPackages
        ++ globalPackages;
  };
}

