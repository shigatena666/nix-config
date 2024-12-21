{ pkgs, lib, config, ... }:

let
  cfg = config.virtualization;
in
{
  options.virtualization = with lib; {
    enable = mkEnableOption "enables virtualization module";
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
          virt-manager
          virt-viewer
          qemu
          pciutils
          looking-glass-client
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
