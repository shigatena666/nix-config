{lib, pkgs, ...}: let
  aerospace_config = ./../../files/configs/aerospace;
in {
  home.file.".aerospace.toml" = {
    source = "${aerospace_config}/aerospace.toml";
  };
}