{ pkgs, lib, config, ... }:

{
  options.security = {
    enable = lib.mkEnableOption "enables security module";
    system = {
      mac = lib.mkEnableOption "enables mac system configuration";
      linux = lib.mkEnableOption "enables linux system configuration";
      windows = lib.mkEnableOption "enables windows system configuration";
    };
  };

  config = lib.mkIf config.security.enable {
    environment.systemPackages = with pkgs; [
      sops
      gnupg
      openvpn
    ]
    ++ lib.optionals config.generic.system.linux [
      tor-browser-bundle-bin
      proton-pass
      protonvpn-gui
    ];
  };
}
