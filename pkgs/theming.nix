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
    home.packages = with pkgs; [
      gnome.gnome-shell-extensions
      gnome.gnome-control-center
      gnomeExtensions.dash-to-dock
      gnomeExtensions.gsnap
      gnomeExtensions.gsconnect
      gnomeExtensions.alphabetical-app-grid
      gnomeExtensions.no-overview
      gnomeExtensions.blur-my-shell
      gnomeExtensions.another-window-session-manager
      gnomeExtensions.hibernate-status-button
      whitesur-icon-theme
      whitesur-cursors
      xdg-desktop-portal-gnome
      dracula-theme
      dracula-icon-theme
      vscode-extensions.dracula-theme.theme-dracula
      ocs-url
    ];

    gtk = {
      enable = true;
      iconTheme.name = "Dracula";
      cursorTheme.name = "WhiteSur-cursors";
      theme = {
        name = "Dracula";
        package = pkgs.dracula-theme;
      };
    };
  };
}
