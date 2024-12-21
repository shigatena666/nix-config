{
  inputs,
  hostname,
  ...
}: {
  imports = [
    inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-gpu-amd
    inputs.hardware.nixosModules.common-pc-ssd

    ./hardware-configuration.nix
    ../../pkgs/modules/common.nix
    ../../pkgs/modules/boot.nix
    ../../pkgs/modules/hyprland.nix
    ../../pkgs/modules/gnome.nix
    ../../pkgs/modules/steam.nix
  ];

  gaming.enable = true;
  generic.enable = true;
  generic.system.linux = true;
  messengers.enable = true;
  networking.enable = true;
  pentesting.enable = true;
  programming.enable = true;
  programming.system.linux = true;
  security.enable = true;
  storage.enable = true;
  theming.enable = true;
  theming.system.linux = true;
  virtualization.enable = true;

  # Set hostname
  networking.hostName = hostname;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  system.stateVersion = "24.11";
}
