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
      pkgs.gnome-shell-extensions
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

    catppuccin.enable = true;
    catppuccin.flavor = "mocha";
    catppuccin.accent = "pink";

    gtk = {
      enable = true;
      catppuccin.enable = true;
      catppuccin.flavor = "mocha";
      catppuccin.accent = "pink";
      iconTheme = {
        name = "Tela";
        package = pkgs.tela-icon-theme;
      };
    };

    # gtk = {
    #   enable = true;
    #   theme = {
    #     name = "catppuccin-mocha-pink-standard"; # catppuccin-mocha-pink-standard
    #     package = pkgs.catppuccin-gtk.override {
    #       accents = [ "pink" ];
    #       size = "standard";
    #       tweaks = [ "normal" ];
    #       variant = "mocha";
    #     };
    #   };
    #   iconTheme = {
    #     name = "Tela";
    #     package = pkgs.tela-icon-theme;
    #   };
    #   gtk3.extraConfig = {
    #     Settings = ''
    #       gtk-application-prefer-dark-theme=1
    #     '';
    #   };
    #   gtk4.extraConfig = {
    #     Settings = ''
    #       gtk-application-prefer-dark-theme=1
    #     '';
    #   };
    # };
  };
}
