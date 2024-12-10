{ config, pkgs, ... }:

{
    wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;

      settings = {
        input = {
          kb_layout = "fr";
          kb_variant = "";
          kb_model = "";
          kb_options = "";
          kb_rules = "";
        };
        env = [
          "XCURSOR_THEME,Catppuccin-Mocha-Mauve-Cursors"
          "XCURSOR_SIZE,24"
          "HYPRCURSOR_THEME,Catppuccin-Mocha-Mauve-Cursors"
          "HYPRCURSOR_SIZE,24"
          "GTK_THEME,"
        ];
        exec-once = [
          "hyprpanel"
          "[workspace 1 silent] google-chrome-stable"
          "[workspace 2 silent] warp-terminal"
          "[workspace 5 silent] code"
          "[workspace 3 silent] vesktop"
          "[workspace 4 silent] youtube-music"
          "sudo uni-sync"
          "openrgb --profile purple"
        ];
        windowrule = [
          "workspace 3 silent, ^(vesktop)$"
        ];
        bind = [
          "SUPER, A, exec, warp-terminal"
          "SUPER, Q, killactive,"
          "SUPER, L, exit,"
          "SUPER, E, exec, dolphin"
          "SUPER, V, togglefloating,"
          "CTRL, SPACE, exec, rofi -show drun"
          "SUPER, left, movewindow, l"
          "SUPER, right, movewindow, r"
          "SUPER, up, movewindow, u"
          "SUPER, down, movewindow, d"
          "SUPER LSHIFT, left, resizeactive, -20 0"
          "SUPER LSHIFT, right, resizeactive, 20 0"
          "SUPER LSHIFT, up, resizeactive, 0 -20"
          "SUPER LSHIFT, down, resizeactive, 0 20"
          "CTRL ALT, left, workspace, -1"
          "CTRL ALT, right, workspace, +1"
          "SUPER, mouse:272, movewindow"   
        ];
        general = {
          border_size = 2;
          "col.active_border" = "$pink";
          "col.inactive_border" = "$surface0";
          resize_on_border = true;
        };
        decoration = {
          rounding = 10;
          active_opacity = 0.9;
          inactive_opacity = 0.9;
          fullscreen_opacity = 1.0;
        };
        source = ''~/.config/hypr/mocha.conf'';
      };
    };

    nixpkgs.config.allowUnfree = true;
    nixpkgs.config.firefox.enableGnomeExtensions = true;
}
