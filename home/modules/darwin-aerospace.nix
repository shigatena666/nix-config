{lib, pkgs, ...}: let
  aerospace_config = ./../../files/configs/aerospace;
in {

   home.packages = with pkgs; [
    nowplaying-cli
  ];

  home.file.".aerospace.toml" = {
    source = "${aerospace_config}/aerospace.toml";
  };
}