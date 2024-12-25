{
  lib,
  inputs,
  hostname,
  userConfig,
  ...
}: 
let
  common = { 
    enable = true; 
    system.wsl = true; 
  };
in
{
  imports = [
    ./hardware-configuration.nix
    ../../pkgs/modules/common.nix
    inputs.nixos-wsl.nixosModules.default
  ];

  # System packages
  gaming_pkgs = common;
  generic_pkgs = common;
  messengers_pkgs = common;
  networking_pkgs = common;
  pentesting_pkgs = common;
  programming_pkgs = common;
  security_pkgs = common;
  storage_pkgs = common;
  theming_pkgs = common;

  # Set hostname
  networking.hostName = hostname;
  
  # Activate WSL
  wsl = {
    enable = true;
    defaultUser = userConfig.name;
    nativeSystemd = true;
    wslConf.automount.root = "/mnt";
    wslConf.interop.appendWindowsPath = false;
  };

  # Nix-ld allows for binary packages without Nix, used for VScode
  programs.nix-ld.enable = true;

  # Activate Tailscale
  services.tailscale.enable = true;

  # Used for GWSL2 (Tailscale needed)
  environment.sessionVariables = {
    DISPLAY="Sun:0.0";
    LIBGL_ALWAYS_INDIRECT=1;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  system.stateVersion = "24.11";
}
