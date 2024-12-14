{ pkgs, lib, config, ... }:

{
  options.networking = {
    enable = lib.mkEnableOption "enables networking module";
    system = {
      mac = lib.mkEnableOption "enables mac system configuration";
      linux = lib.mkEnableOption "enables linux system configuration";
      windows = lib.mkEnableOption "enables windows system configuration";
    };
  };

  config = lib.mkIf config.networking.enable {
    environment.systemPackages = with pkgs; [
      tailscale
      speedtest-go
      wget
    ];
  };
}
