{lib, pkgs, ...}: let
  sketchybar_config = ./../../files/configs/sketchybar;
in {
  # Install sketchybar via home-manager package
  home.packages = with pkgs; [
    sketchybar
  ];

  xdg.configFile = {
    "sketchybar" = {
      recursive = true;
      source = "${sketchybar_config}";
    };
  };
}
