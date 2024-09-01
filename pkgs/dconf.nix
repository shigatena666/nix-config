{ pkgs, lib, config, ... }:

with lib.hm.gvariant;

{
  options.custom_dconf = {
    enable = lib.mkEnableOption "enables custom dconf module";
    system = {
      mac = lib.mkEnableOption "enables mac system configuration";
      linux = lib.mkEnableOption "enables linux system configuration";
      windows = lib.mkEnableOption "enables windows system configuration";
    };
  };

  config = lib.mkIf config.custom_dconf.enable {

    dconf.settings = {
      "com/usebottles/bottles" = {
        startup-view = "page_list";
        window-height = 634;
        window-width = 1670;
      };

      "org/gnome/Console" = {
        last-window-maximised = false;
        last-window-size = mkTuple [ 1670 1282 ];
      };

      "org/gnome/Extensions" = {
        window-height = 1232;
        window-width = 1670;
      };

      "org/gnome/control-center" = {
        last-panel = "background";
        window-state = mkTuple [ 1670 634 false ];
      };

      "org/gnome/desktop/app-folders" = {
        folder-children = [ "Utilities" "YaST" "Pardus" ];
      };

      "org/gnome/shell/app-switcher" = {
        current-workspace-only = true;
      };

      "org/gnome/desktop/app-folders/folders/Pardus" = {
        categories = [ "X-Pardus-Apps" ];
        name = "X-Pardus-Apps.directory";
        translate = true;
      };

      "org/gnome/desktop/app-folders/folders/Utilities" = {
        apps = [ "org.gnome.baobab.desktop" "org.gnome.Connections.desktop" "org.gnome.DiskUtility.desktop" "org.gnome.FileRoller.desktop" "org.gnome.seahorse.Application.desktop" "gnome-abrt.desktop" "gnome-system-log.desktop" "nm-connection-editor.desktop" "org.gnome.DejaDup.desktop" "org.gnome.Dictionary.desktop" "org.gnome.fonts.desktop" "org.gnome.tweaks.desktop" "org.gnome.Usage.desktop" "vinagre.desktop" "org.gnome.Loupe.desktop" "org.gnome.Evince.desktop" ];
        categories = [ "X-GNOME-Utilities" ];
        name = "X-GNOME-Utilities.directory";
        translate = true;
      };

      "org/gnome/desktop/app-folders/folders/YaST" = {
        categories = [ "X-SuSE-YaST" ];
        name = "suse-yast.directory";
        translate = true;
      };

      "org/gnome/desktop/background" = {
        color-shading-type = "solid";
        picture-options = "zoom";
        picture-uri = "file:///home/violette/Documents/GitHub/nix-config/.config/background.png";
        picture-uri-dark = "file:///home/violette/Documents/GitHub/nix-config/.config/background.png";
        primary-color = "#241f31";
        secondary-color = "#000000";
      };

      "org/gnome/desktop/input-sources" = {
        sources = [ (mkTuple [ "xkb" "fr+azerty" ]) ];
        xkb-options = [ "terminate:ctrl_alt_bksp" ];
      };

      "org/gnome/desktop/interface" = {
        color-scheme="prefer-dark";
        enable-animations=true;
        gtk-theme = "catppuccin-mocha-pink-standard";
      };

      "org/gnome/desktop/notifications" = {
        application-children = [ "org-gnome-console" "org-gnome-fileroller" "code-url-handler" "com-usebottles-bottles" ];
      };

      "org/gnome/desktop/notifications/application/code-url-handler" = {
        application-id = "code-url-handler.desktop";
      };

      "org/gnome/desktop/notifications/application/com-usebottles-bottles" = {
        application-id = "com.usebottles.bottles.desktop";
      };

      "org/gnome/desktop/notifications/application/dev-warp-warp" = {
        application-id = "dev.warp.Warp.desktop";
      };

      "org/gnome/desktop/notifications/application/firefox" = {
        application-id = "firefox.desktop";
      };

      "org/gnome/desktop/notifications/application/org-gnome-console" = {
        application-id = "org.gnome.Console.desktop";
      };

      "org/gnome/desktop/notifications/application/org-gnome-fileroller" = {
        application-id = "org.gnome.FileRoller.desktop";
      };

      "org/gnome/desktop/screensaver" = {
        color-shading-type = "solid";
        picture-options = "zoom";
        picture-uri = "file:///run/current-system/sw/share/backgrounds/gnome/blobs-l.svg";
        primary-color = "#241f31";
        secondary-color = "#000000";
      };

      "org/gnome/epiphany" = {
        ask-for-default = false;
      };

      "org/gnome/epiphany/state" = {
        is-maximized = false;
        window-size = mkTuple [ 1024 768 ];
      };

      "org/gnome/evolution-data-server" = {
        migrated = true;
      };

      "org/gnome/file-roller/dialogs/extract" = {
        height = 800;
        recreate-folders = true;
        skip-newer = false;
        width = 1000;
      };

      "org/gnome/file-roller/file-selector" = {
        show-hidden = false;
        sidebar-size = 300;
        window-size = mkTuple [ (-1) (-1) ];
      };

      "org/gnome/file-roller/listing" = {
        list-mode = "as-folder";
        name-column-width = 1120;
        show-path = false;
        sort-method = "name";
        sort-type = "ascending";
      };

      "org/gnome/file-roller/ui" = {
        sidebar-width = 200;
        window-height = 1237;
        window-width = 1670;
      };

      "org/gnome/nautilus/preferences" = {
        default-folder-viewer = "icon-view";
        migrated-gtk-settings = true;
        search-filter-time-type = "last_modified";
      };

      "org/gnome/nautilus/window-state" = {
        initial-size = mkTuple [ 1722 1232 ];
        maximized = false;
      };

      "org/gnome/settings-daemon/plugins/color" = {
        night-light-enabled = false;
      };

      "org/gnome/shell" = {
        disabled-extensions = [ "widgets@aylur" "light-style@gnome-shell-extensions.gcampax.github.com" "window-list@gnome-shell-extensions.gcampax.github.com" ];
        enabled-extensions = [ "dash-to-dock@micxgx.gmail.com" "gSnap@micahosborne" "gsconnect@andyholmes.github.io" "AlphabeticalAppGrid@stuarthayhurst" "system-monitor@gnome-shell-extensions.gcampax.github.com" "user-theme@gnome-shell-extensions.gcampax.github.com" "auto-move-windows@gnome-shell-extensions.gcampax.github.com" "no-overview@fthx" "blur-my-shell@aunetx" "another-window-session-manager@gmail.com" "hibernate-status@dromi"];
        favorite-apps = [ "nautilus.desktop" "dev.warp.Warp.desktop" "org.gnome.Settings.desktop" "Separator 1.desktop" "firefox.desktop" "com.rtosta.zapzap.desktop" "vesktop.desktop" "signal-desktop.desktop" "slack.desktop" "youtube-music.desktop" "Separator 2.desktop" "code.desktop" "github-desktop.desktop" "protonvpn-app.desktop" "proton-pass.desktop" "org.gnome.seahorse.Application.desktop" "Separator 3.desktop" "page.kramo.Cartridges.desktop" ];
        last-selected-power-profile = "performance";
        welcome-dialog-last-shown-version = "46.2";
      };

      "org/gnome/shell/extensions/user-theme" = {
        name = "catppuccin-mocha-pink-standard";
      };

      "org/gnome/shell/extensions/auto-move-windows" = {
        application-list = ["beeper.desktop:2" "signal-desktop.desktop:2" "youtube-music.desktop:2" "dev.warp.Warp.desktop:1" "firefox.desktop:1" "ranger.desktop:1" "org.gnome.Nautilus.desktop:1" "code.desktop:1" "vesktop.desktop:2" "slack.desktop:2" "proton-pass.desktop:3" "protonvpn-app.desktop:3"];
      };

      "org/gnome/shell/extensions/blur-my-shell" = {
      hacks-level = 1;
      pipelines = ''{
        'pipeline_default': {
          'name': 'Default',
          'effects': [
            {
              'type': 'native_static_gaussian_blur',
              'id': 'effect_000000000000',
              'params': {
                'radius': 30,
                'brightness': 0.6
              }
            }
          ]
        },
        'pipeline_default_rounded': {
          'name': 'Default rounded',
          'effects': [
            {
              'type': 'native_static_gaussian_blur',
              'id': 'effect_000000000001',
              'params': {
                'radius': 30,
                'brightness': 0.6
              }
            },
            {
              'type': 'corner',
              'id': 'effect_000000000002',
              'params': {
                'radius': 24
              }
            }
          ]
        }
      }'';
      settings-version = 2;
      };

      "org/gnome/shell/extensions/blur-my-shell/appfolder" = {
        brightness=0.59999999999999998;
        sigma=30;
      };

      "org/gnome/shell/extensions/blur-my-shell/applications" = {
        blur=true;
        blur-on-overview=true;
        brightness=1.0;
        dynamic-opacity=false;
        enable-all=true;
        opacity=220;
        sigma=20;
      };

      "org/gnome/shell/extensions/blur-my-shell/dash-to-dock" = {
        blur=true;
        brightness=0.59999999999999998;
        pipeline="pipeline_default_rounded";
        sigma=30;
        static-blur=true;
        style-dash-to-dock=0;
        unblur-in-overview=false;
      };

      "org/gnome/shell/extensions/blur-my-shell/lockscreen" = {
        pipeline="pipeline_default";
      };

      "org/gnome/shell/extensions/blur-my-shell/overview" = {
        pipeline="pipeline_default";
      };

      "org/gnome/shell/extensions/blur-my-shell/panel" = {
        blur=true;
        brightness=1.0;
        pipeline="pipeline_default";
        sigma=0;
      };

      "org/gnome/shell/extensions/blur-my-shell/screenshot" = {
        pipeline="pipeline_default";
      };

      "org/gnome/shell/extensions/blur-my-shell/window-list" = {
        brightness=0.59999999999999998;
        sigma=30;
      };

      "org/gnome/shell/extensions/dash-to-dock" = {
        always-center-icons = false;
        apply-custom-theme = false;
        apply-glossy-effect = false;
        background-opacity = 0.75;
        custom-background-color = false;
        custom-theme-customize-running-dots = false;
        custom-theme-shrink = false;
        dance-urgent-applications = true;
        dash-max-icon-size = 48;
        disable-overview-on-startup = true;
        dock-fixed = true;
        dock-position = "BOTTOM";
        extend-height = false;
        height-fraction = 0.9;
        hide-tooltip = false;
        icon-size-fixed = false;
        intellihide = false;
        max-alpha = 0.8;
        multi-monitor = false;
        preferred-monitor = -2;
        preferred-monitor-by-connector = "DP-3h";
        running-indicator-dominant-color = true;
        running-indicator-style = "DOTS";
        scroll-to-focused-application = true;
        show-apps-at-top = true;
        show-favorites = true;
        show-icons-emblems = true;
        show-mounts = false;
        show-trash = false;
        show-windows-preview = true;
        transparency-mode = "DYNAMIC";
        unity-backlit-items = false;
        workspace-agnostic-urgent-windows = true;
      };

      "org/gnome/shell/extensions/gsconnect" = {
        id = "190c6dac-4971-439d-b134-7139d522392d";
        name = "nixos";
      };

      "org/gnome/shell/extensions/gsnap" = {
        grid-override = [ "(0,0,1,1)" "(1,0,1,1)" "(2,0,1,1)" "(0,1,1,1)" "(1,1,1,1)" "(2,1,1,1)" ];
        grid-sizes = [ "3x2" ];
        hold-ctrl-to-snap = true;
        show-icon = true;
        window-margin = 7;
      };

      "org/gnome/shell/world-clocks" = {
        locations = [];
      };

      "org/gtk/gtk4/settings/file-chooser" = {
        date-format = "regular";
        location-mode = "path-bar";
        show-hidden = false;
        sidebar-width = 140;
        sort-column = "name";
        sort-directories-first = true;
        sort-order = "ascending";
        type-format = "category";
        view-type = "list";
        window-size = mkTuple [ 921 372 ];
      };

      "org/gtk/settings/file-chooser" = {
        date-format = "regular";
        location-mode = "path-bar";
        show-hidden = false;
        show-size-column = true;
        show-type-column = true;
        sidebar-width = 197;
        sort-column = "name";
        sort-directories-first = false;
        sort-order = "ascending";
        type-format = "category";
        window-position = mkTuple [ 26 23 ];
        window-size = mkTuple [ 1231 902 ];
      };

    };
  };
}