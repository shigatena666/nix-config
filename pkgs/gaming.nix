{ pkgs, lib, config, ... }:

{
  options.gaming = {
    enable = lib.mkEnableOption "enables gaming module";
      system = {
      mac = lib.mkEnableOption "enables mac system configuration";
      linux = lib.mkEnableOption "enables linux system configuration";
      windows = lib.mkEnableOption "enables windows system configuration";
    };
  };

  config = lib.mkIf config.gaming.enable {
    home.packages = with pkgs; [
      protonup
      lutris
      heroic
      bottles
      cartridges
    ];
    home.sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS =
        "\\\${HOME}/.steam/root/compatibilitytools.d";
  };
  };
}