{pkgs, ...}: let
  hyprpanel_config = ./../../files/configs/hyprpanel;
in {
  # Install hyprpanel via home-manager package
  home.packages = with pkgs; [
    hyprpanel
  ];

  # Source hyprpanel config from the home-manager store
  xdg.configFile = {
    "hyprpanel" = {
      recursive = true;
      source = "${hyprpanel_config}";
    };
  };
}
