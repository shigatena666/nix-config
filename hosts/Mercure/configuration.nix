{
  inputs,
  hostname,
  userConfig,
  pkgs,
  ...
}: 
let
  common = { 
    enable = true; 
    system.linux = true; 
  };
in
{
  imports = [
    inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-gpu-amd
    inputs.hardware.nixosModules.common-pc-ssd

    ./hardware-configuration.nix
    ../../pkgs/modules/common.nix
    ../../pkgs/modules/boot.nix
    ../../pkgs/modules/greetd.nix
    ../../pkgs/modules/hyprland.nix
    ../../pkgs/modules/gnome.nix
    ../../pkgs/modules/steam.nix
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

  # Activate Tailscale
  services.tailscale.enable = true;

  # Enable sudo for uni-sync and tailscale
  security.sudo.extraRules = [{
    users = [ userConfig.name ];
    commands = [
      {
        command = "${pkgs.tailscale}/bin/tailscale";
        options = [ "NOPASSWD" ];
      }
      {
        command = "${pkgs.uni-sync}/bin/uni-sync";
        options = [ "NOPASSWD" ];
      }
    ];
  }];

  # Enable uni-sync
  hardware.uni-sync.enable = true;
  environment.etc."uni-sync/uni-sync.json" = { 
    source = ../../files/configs/uni-sync/uni-sync.json;
  };
  systemd.services.uni-sync = {
    description = "Run uni-sync command on startup";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.sudo}/bin/sudo ${pkgs.uni-sync}/bin/uni-sync";
      User = "root";
    };
  };

  # Enable OpenRGB
  services.hardware.openrgb.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  system.stateVersion = "24.11";
}
