{ pkgs, lib, config, ... }:

{
  options.programming = {
    enable = lib.mkEnableOption "enables programming module";
    system = {
      mac = lib.mkEnableOption "enables mac system configuration";
      linux = lib.mkEnableOption "enables linux system configuration";
      windows = lib.mkEnableOption "enables windows system configuration";
      wsl = lib.mkEnableOption "enables WSL system configuration";
    };
  };

  config = lib.mkIf config.programming.enable {
    environment.systemPackages = with pkgs; [
      git
      nodejs_22
      python3
      pnpm
      bun
      gh
      wget
    ]
    ++ lib.optionals (config.programming.system.linux) [
      github-desktop
    ]
    ++ lib.optionals (!config.programming.system.wsl) [
      vscode
    ];
  };
}
