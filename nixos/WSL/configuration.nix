# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{

imports = [
    # include NixOS-WSL modules
    <nixos-wsl/modules>
];

wsl.enable = true;
wsl.defaultUser = "violette";

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
