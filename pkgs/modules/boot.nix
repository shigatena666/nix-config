{
  inputs,
  outputs,
  lib,
  config,
  userConfig,
  pkgs,
  ...
}: {
  # Boot settings
  boot = {
    # kernelPackages = pkgs.linuxPackages_latest;
    consoleLogLevel = 0;
    initrd.verbose = false;
    kernelParams = [  
      "quiet"
      "splash"
      "plymouth.enable=0"
      "loglevel=3"
      "rd.systemd.show_status=auto"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];
    loader.efi.canTouchEfiVariables = true;
    loader.systemd-boot.enable = true;
    loader.timeout = 0;
    plymouth = {
      enable = true;
      themePackages = [
        (pkgs.adi1090x-plymouth-themes.override {
          selected_themes = [ "lone" ];
        })
      ];
      theme = "lone";
    };
  };
}
