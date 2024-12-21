{
  lib,
  inputs,
  hostname,
  userConfig,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../pkgs/modules/common.nix
    inputs.nixos-wsl.nixosModules.default
  ];

  virtualization.enable = false;
  theming.enable = false;
  gaming.enable = false;

  common = {
    enable = true;
    system.wsl = true;
  };

  generic = common;
  messengers = common;
  networking = common;
  pentesting = common;
  programming = common;
  security = common;
  storage = common;

  # Set hostname
  networking.hostName = hostname;
  
  wsl = {
    enable = true;
    defaultUser = userConfig.name;
    nativeSystemd = true;
    wslConf.automount.root = "/mnt";
    wslConf.interop.appendWindowsPath = false;
  };

  programs.nix-ld.enable = true;

  environment.sessionVariables = {
    DISPLAY="Sun:0.0";
    LIBGL_ALWAYS_INDIRECT=1;
  };

  services.tailscale.enable = true;


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  system.stateVersion = "24.11";
}
