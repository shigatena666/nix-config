{ config, pkgs, ... }:

{
  services.yabai = {
    enable = true;  # Enable the Yabai service
    package = pkgs.yabai;  # Use the Yabai package from nixpkgs
    enableScriptingAddition = true;  # Enable scripting addition for advanced features
    config = {
      focus_follows_mouse = "autoraise";
      mouse_follows_focus = "off";
      window_placement = "second_child";
      window_opacity = "off";
      window_opacity_duration = "0.0";
      window_border = "on";
      window_border_placement = "inset";
      window_border_width = 2;
      window_border_radius = 3;
      active_window_border_topmost = "off";
      window_topmost = "on";
      window_shadow = "float";
      active_window_border_color = "0xff5c7e81";
      normal_window_border_color = "0xff505050";
      insert_window_border_color = "0xffd75f5f";
      active_window_opacity = "1.0";
      normal_window_opacity = "1.0";
      split_ratio = "0.50";
      auto_balance = "on";
      mouse_modifier = "fn";  # Modifier key for mouse actions
      mouse_action1 = "move";  # Action for primary mouse button
      mouse_action2 = "resize";  # Action for secondary mouse button
      layout = "bsp";  # Use binary space partitioning layout
      top_padding = 36;
      bottom_padding = 10;
      left_padding = 10;
      right_padding = 10;
      window_gap = 10;  # Gap between windows
    };
    extraConfig = ''
      # Add custom rules or commands here
      yabai -m rule --add app='System Preferences' manage=off;
    '';
  };
}
