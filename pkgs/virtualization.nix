{ pkgs, lib, config, ... }:

{
  options.virtualization = {
    enable = lib.mkEnableOption "enables virtualization module";
    system = {
      mac = lib.mkEnableOption "enables mac system configuration";
      linux = lib.mkEnableOption "enables linux system configuration";
      windows = lib.mkEnableOption "enables windows system configuration";
    };
  };

  config = lib.mkIf config.virtualization.enable {
    environment.systemPackages = with pkgs; [
        virt-manager
        virt-viewer
        qemu
        pciutils
        looking-glass-client
    ];
  };
}