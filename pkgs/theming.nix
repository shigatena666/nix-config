{ inputs, pkgs, lib, config, ... }:

let
  cfg = config.theming_pkgs;
in
{
  options.theming_pkgs = with lib; {
    enable = mkEnableOption "enables theming packages";
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
          vscode-extensions.dracula-theme.theme-dracula
          ocs-url
          solaar
          uni-sync
          openrgb-with-all-plugins
          inputs.hyprswitch.packages.${pkgs.stdenv.hostPlatform.system}.default
        ];

        macPackages = [
          aerospace
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
