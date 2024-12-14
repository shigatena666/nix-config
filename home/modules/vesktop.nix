{
  pkgs,
  lib,
  ...
}: let
  vesktop_config = ./../../files/configs/vesktop;
in {
  # vesktop package
  home.packages = with pkgs; [
    vesktop
  ];

  # Source vesktop configuration from this repository
  xdg.configFile = {
    "vesktop" = {
      recursive = true;
      source = "${ulauncher_config}";
    };
  };
}
