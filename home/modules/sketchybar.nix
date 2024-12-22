{lib, pkgs, ...}: let
  sketchybar_config = ./../../files/configs/sketchybar;
in {
  xdg.configFile = {
    "sketchybar" = {
      recursive = true;
      source = "${sketchybar_config}";
    };
  };
}
