{ pkgs, lib, config, ... }:

let
  cfg = config.programming_pkgs;
in
{
  options.programming_pkgs = with lib; {
    enable = mkEnableOption "enables programming packages";
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
          github-desktop
        ];

        macPackages = [
        ];

        wslPackages = [
        ];

        globalPackages = [
          git
          nodejs_22
          python3
          pnpm
          bun
          gh
          wget
        ];

      in lib.optionals cfg.system.linux linuxPackages
         ++ lib.optionals cfg.system.mac macPackages
         ++ lib.optionals cfg.system.wsl wslPackages
         ++ globalPackages;
  };
}



