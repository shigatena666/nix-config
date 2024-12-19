{ pkgs, lib, config, ... }:

let
  cfg = config.theming;
in
{
  options.theming = with lib; {
    enable = mkEnableOption "enables theming module";
    system = {
      mac = mkEnableOption "enables macOS system configuration";
      linux = mkEnableOption "enables Linux system configuration";
      windows = mkEnableOption "enables Windows system configuration";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs;
      let
        linuxPackages = [
          vscode-extensions.dracula-theme.theme-dracula
          ocs-url
          solaar
          hyprlandPlugins.hyprbars
          uni-sync
          dunst
          hyprpanel 
          hyprsunset 
          hypridle
          openrgb-with-all-plugins
        ];

        macPackages = [
          aerospace
        ];

        windowsPackages = [
        ]; 

      in lib.optionals cfg.system.linux linuxPackages
         ++ lib.optionals cfg.system.mac macPackages
         ++ lib.optionals cfg.system.windows windowsPackages;
  };
}
