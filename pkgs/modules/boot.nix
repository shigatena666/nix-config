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
    kernelParams = ["quiet" "splash"];
    loader.efi.canTouchEfiVariables = true;
    loader.systemd-boot.enable = true;
    loader.timeout = 0;
    plymouth.enable = true;
    plymouth.themePackages = [
      (pkgs.adi1090x-plymouth-themes.override {
        selected_themes = [ "lone" ];
      })
    ];
  };
}
