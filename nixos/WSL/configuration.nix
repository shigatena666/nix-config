{ config, pkgs, lib, ... }:

{
  imports =
  [
    <nixos-wsl/modules>
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  wsl = {
    enable = true;
    defaultUser = "violette";
    startMenuLaunchers = true;
    nativeSystemd = true;
    wslConf.automount.root = "/mnt";
    wslConf.interop.appendWindowsPath = false;
  };

  programs.nix-ld.enable = true;

  networking.hostName = "WSL"; 
  networking.networkmanager.enable = true;
  systemd.services.NetworkManager-wait-online.enable = false;

  time.timeZone = "Europe/Paris";

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

  console.keyMap = "fr";

  services.printing.enable = true;

  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.violette = {
    isNormalUser = true;
    description = "Violette";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
    packages = with pkgs; [
      xorg.xauth
      xorg.xinit
      xorg.xsetroot
      xorg.xrandr
      xorg.xhost
      # Add any other packages you may need
    ];
  };

   # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.displayManager.startx.enable = true;

  programs.firefox.enable = true;

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ]; 

  environment.systemPackages = with pkgs; [
    home-manager
    git
  ];

  environment.sessionVariables = {
    DISPLAY="Sun:0.0"; # Dynamically set DISPLAY to Windows host IP
    LIBGL_ALWAYS_INDIRECT=1; # Ensure indirect rendering is used
  };

  services.tailscale.enable = true;

  services.neo4j.enable = true;
  
  virtualisation.docker.enable = true;
  users.extraGroups.docker.members = [ "violette" ];

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  system.stateVersion = "23.05"; 
}
