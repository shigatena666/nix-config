{
  pkgs,
  lib,
  ...
}: let
  spicetify_config = ./../../files/configs/spicetify;
in {
  # spicetify package
  home.packages = with pkgs; [
    spicetify-cli
  ];

  # Source spicetify configuration from this repository
  xdg.configFile = {
    "spicetify" = {
      recursive = true;
      source = "${spicetify_config}";
    };
  };
}
