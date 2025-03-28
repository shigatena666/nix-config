{lib, pkgs, ...}: let
  hyprpanel_config = ./../../files/configs/hyprpanel;
in {
  # Install hyprpanel via home-manager package
  home.packages = with pkgs; [
    hyprpanel
  ];

  xdg.configFile = {
    "hyprpanel" = {
      recursive = true;
      source = "${hyprpanel_config}";
    };
  };
  # Need to source /tmp/ags/hyprpanel/ from hyprpanel_config var.
}
