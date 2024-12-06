# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, catppuccin, ... }:

{
imports =
[ # Include the results of the hardware scan.
    ./hardware-configuration.nix
];

# Bootloader.
boot.loader.systemd-boot.enable = true;
boot.loader.efi.canTouchEfiVariables = true;

boot = {
  kernelModules = [ "fb" "fbcon" "drm" "drm_kms_helper" "vfio_pci" "vfio" "vfio_iommu_type1" "vfio_virqfd" "amdgpu" "i2c-dev" "i2c-piix4"];
  plymouth = {
    enable = true;
    themePackages = [ pkgs.nixos-bgrt-plymouth ];
  };
  initrd.verbose = false;
  consoleLogLevel = 0;
  kernelParams = [ "quiet" "splash" "amd_iommu=on" "pcie_acs_override=downstream,multifunction" ];
  extraModprobeConfig = "options vfio-pci ids=10de:1189,10de:0e0a";
  blacklistedKernelModules = [ "nvidia" ];
};

hardware.i2c.enable = true;

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

# Enable OpenRGB.
services.hardware.openrgb.enable = true;

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
  hyprpanel
  hyprsunset
  hypridle
  catppuccin-cursors
];

fonts.packages = with pkgs; [
  nerd-fonts._3270
  nerd-fonts.agave
  nerd-fonts.anonymice
  nerd-fonts.arimo
  nerd-fonts.aurulent-sans-mono
  nerd-fonts.bigblue-terminal
  nerd-fonts.bitstream-vera-sans-mono
  nerd-fonts.blex-mono
  nerd-fonts.caskaydia-cove
  nerd-fonts.caskaydia-mono
  nerd-fonts.code-new-roman
  nerd-fonts.comic-shanns-mono
  nerd-fonts.commit-mono
  nerd-fonts.cousine
  nerd-fonts.d2coding
  nerd-fonts.daddy-time-mono
  nerd-fonts.departure-mono
  nerd-fonts.dejavu-sans-mono
  nerd-fonts.droid-sans-mono
  nerd-fonts.envy-code-r
  nerd-fonts.fantasque-sans-mono
  nerd-fonts.fira-code
  nerd-fonts.fira-mono
  nerd-fonts.geist-mono
  nerd-fonts.go-mono
  nerd-fonts.gohufont
  nerd-fonts.hack
  nerd-fonts.hasklug
  nerd-fonts.heavy-data
  nerd-fonts.hurmit
  nerd-fonts.im-writing
  nerd-fonts.inconsolata
  nerd-fonts.inconsolata-go
  nerd-fonts.inconsolata-lgc
  nerd-fonts.intone-mono
  nerd-fonts.iosevka
  nerd-fonts.iosevka-term
  nerd-fonts.iosevka-term-slab
  nerd-fonts.jetbrains-mono
  nerd-fonts.lekton
  nerd-fonts.liberation
  nerd-fonts.lilex
  nerd-fonts.martian-mono
  nerd-fonts.meslo-lg
  nerd-fonts.monaspace
  nerd-fonts.monofur
  nerd-fonts.monoid
  nerd-fonts.mononoki
  nerd-fonts.mplus
  nerd-fonts.noto
  nerd-fonts.open-dyslexic
  nerd-fonts.overpass
  nerd-fonts.profont
  nerd-fonts.proggy-clean-tt
  nerd-fonts.recursive-mono
  nerd-fonts.roboto-mono
  nerd-fonts.shure-tech-mono
  nerd-fonts.sauce-code-pro
  nerd-fonts.space-mono
  nerd-fonts.symbols-only
  nerd-fonts.terminess-ttf
  nerd-fonts.tinos
  nerd-fonts.ubuntu
  nerd-fonts.ubuntu-mono
  nerd-fonts.ubuntu-sans
  nerd-fonts.victor-mono
  nerd-fonts.zed-mono
];

programs.hyprland.enable = true;
fonts.fontconfig.enable = true;

catppuccin.enable = true;
catppuccin.flavor = "mocha";
catppuccin.accent = "pink";

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

# collect garbage
nix.gc = {
  automatic = true;
  dates = "weekly";
  options = "--delete-older-than 30d";
};

# This value determines the NixOS release from which the default
# settings for stateful data, like file locations and database versions
# on your system were taken. It‘s perfectly fine and recommended to leave
# this value at the release version of the first install of this system.
# Before changing this value read the documentation for this option
# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
system.stateVersion = "23.05"; # Did you read the comment?

}
