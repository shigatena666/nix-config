{ pkgs, lib, config, ... }:

{
  options.storage = {
    enable = lib.mkEnableOption "enables storage module";
    system = {
      mac = lib.mkEnableOption "enables mac system configuration";
      linux = lib.mkEnableOption "enables linux system configuration";
      windows = lib.mkEnableOption "enables windows system configuration";
    };
  };

  config = lib.mkIf config.storage.enable {
    home.packages = with pkgs; [
      rclone
      mount
      fzf
    ];
    
  };
}
