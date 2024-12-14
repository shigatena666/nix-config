{ pkgs, lib, config, ... }:

{
  options.messengers = {
    enable = lib.mkEnableOption "enables messengers module";
    system = {
      mac = lib.mkEnableOption "enables mac system configuration";
      linux = lib.mkEnableOption "enables linux system configuration";
      windows = lib.mkEnableOption "enables windows system configuration";
    };
  };

  config = lib.mkIf config.messengers.enable {
    environment.systemPackages = with pkgs; [
      vesktop
      slack
    ]
    ++ lib.optionals config.generic.system.linux [
      signal-desktop
      beeper
      zapzap
    ]
    ++ lib.optionals config.generic.system.mac [

    ];
  };
}