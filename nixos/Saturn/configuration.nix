{ config, pkgs, lib, username, host, ... }:

{
  nixpkgs.hostPlatform = lib.mkDefault "aarch64-darwin";
  services.nix-daemon.enable = true;
  nix.useDaemon = true;

  nix.settings.substituters = [
    "https://cache.nixos.org/"
    "https://nix-community.cachix.org"
  ];
  nix.settings.trusted-public-keys = [
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
  ];

  system.defaults.dock = {
    autohide = false;
    mru-spaces = false;
    minimize-to-application = true;
    show-recents = false;
    tilesize = 48;
    static-only = false;
    show-process-indicators = true;
  };

  system.defaults.dock.persistent-apps = [
    "/Applications/Nix Apps/Google Chrome.app"
    "/Applications/Nix Apps/Warp.app"
    "/Applications/Nix Apps/Visual Studio Code.app"
    "/Applications/Nix Apps/Vesktop.app"
    "/Applications/Nix Apps/Youtube Music.app"
  ];

  gaming.enable = false;
  messengers.enable = true;
  networking.enable = true;
  pentesting.enable = true;
  security.enable = true;
  storage.enable = true;
  virtualization.enable = false;

  generic.enable = true;
  generic.system.mac = true;

  programming.enable = true;
  programming.system.mac = true;

  theming.enable = true;
  theming.system.mac = true;

  networking = {
    hostName = host;
    computerName = host;
  };

  services.yabai = {
    enable = true;  # Enable the Yabai service
    package = pkgs.yabai;  # Specify the Yabai package (use unstable channel if needed)
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

  nix.settings.experimental-features = [ "nix-command" "flakes" ]; 
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = 1;

}
