{ pkgs, lib, config, ... }:

{
  options.theming = {
    enable = lib.mkEnableOption "enables theming module";
    system = {
      mac = lib.mkEnableOption "enables mac system configuration";
      linux = lib.mkEnableOption "enables linux system configuration";
      windows = lib.mkEnableOption "enables windows system configuration";
    };
  };

  config = lib.mkIf config.theming.enable {
    environment.systemPackages = with pkgs; [
      vscode-extensions.dracula-theme.theme-dracula
      ocs-url
      solaar
      hyprlandPlugins.hyprbars
      uni-sync
      catppuccin-cursors
      dunst
      hyprpanel 
      hyprsunset 
      hypridle
      catppuccin-cursors 
      catppuccin-sddm-corners
      openrgb-with-all-plugins
    ];
  };
} 