{ pkgs, lib, config, ... }:

let
  cfg = config.security_pkgs;
in
{
  options.security_pkgs = with lib; {
    enable = mkEnableOption "enables security packages";
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
          tor-browser-bundle-bin
          proton-pass
          protonvpn-gui
        ];

        macPackages = [
          pinentry_mac
        ];

        wslPackages = [
        ];

        globalPackages = [
          sops
          gnupg
          pinentry-tty
          openvpn
        ];

      in lib.optionals cfg.system.linux linuxPackages
         ++ lib.optionals cfg.system.mac macPackages
         ++ lib.optionals cfg.system.wsl wslPackages
         ++ globalPackages;
  };
}


