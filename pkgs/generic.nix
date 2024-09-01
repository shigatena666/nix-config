{ pkgs, lib, config, ... }:

{
  options.generic = {
    enable = lib.mkEnableOption "enables generic module";
    system = {
      mac = lib.mkEnableOption "enables mac system configuration";
      linux = lib.mkEnableOption "enables linux system configuration";
      windows = lib.mkEnableOption "enables windows system configuration";
    };
  };

  config = lib.mkIf config.generic.enable {
    home.packages = with pkgs;
      [
        warp-terminal
        ani-cli
        neofetch
        youtube-music
        vesktop
        krita
      ]
      ++ lib.optionals config.generic.system.linux [
        dconf2nix
        dconf-editor
        pavucontrol
        efibootmgr
        gtop
        gnumake
      ]
      ++ lib.optionals config.generic.system.mac [
        arc-browser
        iina
        raycast
        rectangle
        hidden-bar
        alt-tab-macos
        unar
      ];

      programs.firefox = {
        enable = true;
        profiles.default = {
          id = 0;
          name = "Default";
          settings = {
            "browser.startup.page" = 3;
            "browser.sessionstore.resume_from_crash" = true;
            "browser.sessionstore.max_resumed_crashes" = -1;
            "browser.tabs.loadInBackground" = true;
            "widget.gtk.rounded-bottom-corners.enabled" = true;
            "gnomeTheme.hideSingleTab" = true;
            "gnomeTheme.bookmarksToolbarUnderTabs" = true;
            "gnomeTheme.normalWidthTabs" = false;
            "gnomeTheme.tabsAsHeaderbar" = false;

            # For Firefox GNOME theme:
            "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
            "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
            "browser.tabs.drawInTitlebar" = true;
            "svg.context-properties.content.enabled" = true;
          };
          userChrome = ''
              @import "firefox-gnome-theme/userChrome.css";
              @import "firefox-gnome-theme/theme/colors/dark.css"; 
          '';
          };
        };
      };
  }