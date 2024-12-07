{ config, pkgs, catppuccin, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  ## Bootloader configuration ##
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot = {
    kernelModules = [
      "fb" "fbcon" "drm" "drm_kms_helper"
      "vfio_pci" "vfio" "vfio_iommu_type1" "vfio_virqfd"
      "amdgpu" "i2c-dev" "i2c-piix4"
    ];
    plymouth.enable = true;
    plymouth.themePackages = [ pkgs.nixos-bgrt-plymouth ];
    initrd.verbose = false;
    consoleLogLevel = 0;
    kernelParams = [
      "quiet" "splash" 
      "amd_iommu=on" 
      "pcie_acs_override=downstream,multifunction"
    ];
    extraModprobeConfig = "options vfio-pci ids=10de:1189,10de:0e0a";
    blacklistedKernelModules = [ "nvidia" ];
  };

  ## Hardware settings ##
  hardware.i2c.enable = true;

  ## Time zone and localization ##
  time.timeZone = "Europe/Paris";
  i18n.defaultLocale = "fr_FR.UTF-8";
  
  i18n.extraLocaleSettings = builtins.listToAttrs (map (loc: { name = loc; value = "fr_FR.UTF-8"; }) [
    "LC_ADDRESS" "LC_IDENTIFICATION" "LC_MEASUREMENT"
    "LC_MONETARY" "LC_NAME" "LC_NUMERIC"
    "LC_PAPER" "LC_TELEPHONE" "LC_TIME"
  ]);

  console.keyMap = "fr";

  ## Sound configuration ##
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  ## User account definition ##
  users.users.violette = {
    isNormalUser = true;
    description = "Violette";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
    packages = [];
  };

  ## Allow unfree packages and experimental features ##
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ]; 

  ## System packages and fonts ##
  environment.systemPackages = with pkgs; [
    git home-manager hyprpanel hyprsunset hypridle
    catppuccin-cursors catppuccin-sddm-corners openrgb-with-all-plugins
    cmake meson cpio
  ];
  
  fonts.packages = with pkgs; [
    nerd-fonts._3270 nerd-fonts.agave nerd-fonts.anonymice nerd-fonts.arimo
    nerd-fonts.aurulent-sans-mono nerd-fonts.bigblue-terminal nerd-fonts.bitstream-vera-sans-mono
    nerd-fonts.blex-mono nerd-fonts.caskaydia-cove nerd-fonts.caskaydia-mono
    nerd-fonts.code-new-roman nerd-fonts.comic-shanns-mono nerd-fonts.commit-mono
    nerd-fonts.cousine nerd-fonts.d2coding nerd-fonts.daddy-time-mono
    nerd-fonts.departure-mono nerd-fonts.dejavu-sans-mono nerd-fonts.droid-sans-mono
    nerd-fonts.envy-code-r nerd-fonts.fantasque-sans-mono nerd-fonts.fira-code
    nerd-fonts.fira-mono nerd-fonts.geist-mono nerd-fonts.go-mono
    nerd-fonts.gohufont nerd-fonts.hack nerd-fonts.hasklug
    nerd-fonts.heavy-data nerd-fonts.hurmit nerd-fonts.im-writing
    nerd-fonts.inconsolata nerd-fonts.inconsolata-go nerd-fonts.inconsolata-lgc
    nerd-fonts.intone-mono nerd-fonts.iosevka nerd-fonts.iosevka-term
    nerd-fonts.iosevka-term-slab nerd-fonts.jetbrains-mono nerd-fonts.lekton
    nerd-fonts.liberation nerd-fonts.lilex nerd-fonts.martian-mono
    nerd-fonts.meslo-lg nerd-fonts.monaspace nerd-fonts.monofur
    nerd-fonts.monoid nerd-fonts.mononoki nerd-fonts.mplus
    nerd-fonts.noto nerd-fonts.open-dyslexic nerd-fonts.overpass
    nerd-fonts.profont nerd-fonts.proggy-clean-tt nerd-fonts.recursive-mono
    nerd-fonts.roboto-mono nerd-fonts.shure-tech-mono nerd-fonts.sauce-code-pro
    nerd-fonts.space-mono nerd-fonts.symbols-only nerd-fonts.terminess-ttf
    nerd-fonts.tinos nerd-fonts.ubuntu nerd-fonts.ubuntu-mono 
    nerd-fonts.ubuntu-sans nerd-fonts.victor-mono nerd-fonts.zed-mono 
  ];

  programs.hyprland.enable = true;
  services.hardware.openrgb.enable = true;
  fonts.fontconfig.enable = true;

  ## Configure sudo and uni-sync ##
  hardware.uni-sync.enable = true;
  environment.etc."uni-sync/uni-sync.json" = { source = ../../.config/uni-sync/uni-sync.json; };

  security.sudo.extraRules = [{
    users = [ "violette" ];
    commands = [{
        command = "/home/violette/.nix-profile/bin/uni-sync";
        options = [ "NOPASSWD" ];
      }];
  }];

  ## Catppuccin theme configuration ##
  catppuccin.enable = true;
  catppuccin.flavor = "mocha";
  catppuccin.accent = "pink";

  ## XKB configuration ##
  services.xserver.xkb = {
    layout = "fr";
  };

  ## Display manager settings for SDDM with Wayland support ##
  services.displayManager.sddm = {
    package = pkgs.kdePackages.sddm;
    enable = true;
    wayland.enable = true;
    settings = {
      X11 = {
        ServerArguments = "-layout fr";
      };
    };
  };

  environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  xdg.portal.enable = true;

  ## Network Configuration ##

  services.tailscale.enable = true;
  networking.hostName = "Sun"; 
  networking.networkmanager.enable = true;
  systemd.services.NetworkManager-wait-online.enable = false;
  
  ## Gaming Configuration ##

  services.xserver.videoDrivers = ["amdgpu"];
  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  programs.gamemode.enable = true;

  ## Pentesting Configuration ##

  virtualisation.docker.enable = true;
  users.extraGroups.docker.members = [ "violette" ];

  ## Virtualization Configuration ##

  virtualisation.libvirtd.enable=true; 
  virtualisation.libvirtd.qemu.swtpm.enable=true; 
  virtualisation.libvirtd.qemu.ovmf.enable=true; 
  virtualisation.libvirtd.qemu.ovmf.packages=[pkgs.OVMFFull.fd]; 

  virtualisation.spiceUSBRedirection.enable=true; 
  services.spice-vdagentd.enable=true;

  ## Swap Configuration ##

  swapDevices=[{ device="/var/lib/swapfile"; size=16*1024; }];

  ## Garbage Collection Configuration ##

  nix.gc.automatic=true; 
  nix.gc.dates="weekly"; 
  nix.gc.options="--delete-older-than=30d";

  ## System State Version ##

  system.stateVersion="23.05"; # Did you read the comment?
}
