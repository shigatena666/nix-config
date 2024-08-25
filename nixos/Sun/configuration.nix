# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
imports =
[ # Include the results of the hardware scan.
    ./hardware-configuration.nix
];

# Bootloader.
boot.loader.systemd-boot.enable = true;
boot.loader.efi.canTouchEfiVariables = true;

boot = {
  kernelModules = [ "fb" "fbcon" "drm" "drm_kms_helper" "vfio_pci" "vfio" "vfio_iommu_type1" "vfio_virqfd" "amdgpu"];
  plymouth = {
    enable = true;
    theme = "nixos-bgrt";
    themePackages = [ pkgs.nixos-bgrt-plymouth ];
  };
  initrd.verbose = false;
  consoleLogLevel = 0;
  kernelParams = [ "quiet" "splash" "amd_iommu=on" "pcie_acs_override=downstream,multifunction" ];
  extraModprobeConfig = "options vfio-pci ids=10de:1189,10de:0e0a";
  blacklistedKernelModules = [ "nvidia" ];
};


networking.hostName = "Sun"; 
networking.networkmanager.enable = true;
systemd.services.NetworkManager-wait-online.enable = false;

# Set your time zone.
time.timeZone = "Europe/Paris";

# Select internationalisation properties.
i18n.defaultLocale = "fr_FR.UTF-8";

i18n.extraLocaleSettings = {
  LC_ADDRESS = "fr_FR.UTF-8";
  LC_IDENTIFICATION = "fr_FR.UTF-8";
  LC_MEASUREMENT = "fr_FR.UTF-8";
  LC_MONETARY = "fr_FR.UTF-8";
  LC_NAME = "fr_FR.UTF-8";
  LC_NUMERIC = "fr_FR.UTF-8";
  LC_PAPER = "fr_FR.UTF-8";
  LC_TELEPHONE = "fr_FR.UTF-8";
  LC_TIME = "fr_FR.UTF-8";
};

# Enable the X11 windowing system.
services.xserver.enable = true;

# Enable the GNOME Desktop Environment.
services.xserver.displayManager.gdm.enable = true;
services.xserver.desktopManager.gnome.enable = true;


# Configure keymap in X11
services.xserver = {
  xkb.layout = "fr";
  xkb.variant = "azerty";
};

# Configure console keymap
console.keyMap = "fr";

# Enable CUPS to print documents.
services.printing.enable = true;

# Enable sound with pipewire.
hardware.pulseaudio.enable = false;
security.rtkit.enable = true;
services.pipewire = {
  enable = true;
  alsa.enable = true;
  alsa.support32Bit = true;
  pulse.enable = true;
};


# Define a user account. Don't forget to set a password with ‘passwd’.
users.users.violette = {
	isNormalUser = true;
	description = "Violette";
	extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
	packages = with pkgs; [
	];
};

# Install firefox.
programs.firefox.enable = true;

# Allow unfree packages
nixpkgs.config.allowUnfree = true;
nix.settings.experimental-features = [ "nix-command" "flakes" ]; 

environment.systemPackages = with pkgs; [
  git
  home-manager
];

environment.sessionVariables = {
  WLR_NO_HARDWARE_CURSORS = "1";
  NIXOS_OZONE_WL = "1";
};
xdg.portal.enable = true;

services.tailscale.enable = true;

# gaming config
# hardware.graphics.enable = true;
# hardware.graphics.enable32Bit = true;
services.xserver.videoDrivers = ["amdgpu"];
programs.steam.enable = true;
programs.steam.gamescopeSession.enable = true;
programs.gamemode.enable = true;

# pentest config
virtualisation.docker.enable = true;
users.extraGroups.docker.members = [ "violette" ];

# virtualization config
virtualisation = {
  libvirtd = {
    enable = true;
    qemu = {
      swtpm.enable = true;
      ovmf.enable = true;
      ovmf.packages = [ pkgs.OVMFFull.fd ];
    };
  };
  spiceUSBRedirection.enable = true;
};
services.spice-vdagentd.enable = true;

# activate swap
swapDevices = [
  {
    device = "/var/lib/swapfile";
    size = 16 * 1024;  # 16GB
  }
];

# This value determines the NixOS release from which the default
# settings for stateful data, like file locations and database versions
# on your system were taken. It‘s perfectly fine and recommended to leave
# this value at the release version of the first install of this system.
# Before changing this value read the documentation for this option
# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
system.stateVersion = "23.05"; # Did you read the comment?

}
