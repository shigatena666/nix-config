{lib, pkgs, ...}: let
  aerospace_config = ./../../files/configs/aerospace;
in {
  xdg.configFile = {
    "aerospace.toml" = {
      source = "${aerospace_config}";
    };
  };
}