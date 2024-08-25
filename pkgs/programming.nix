{ pkgs, lib, config, ... }:

{
  options.programming = {
    enable = lib.mkEnableOption "enables programming module";
    system = {
      mac = lib.mkEnableOption "enables mac system configuration";
      linux = lib.mkEnableOption "enables linux system configuration";
      windows = lib.mkEnableOption "enables windows system configuration";
    };
  };

  config = lib.mkIf config.programming.enable {
    home.packages = with pkgs; [
      vscode
      github-desktop
      nodejs_22
      python3
      pnpm

    ];
  };
}
