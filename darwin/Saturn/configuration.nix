# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-darwin";
  services.nix-daemon.enable = true;
  nix.useDaemon = true;

  system.defaults.dock = {
    autohide = false;
    mru-spaces = false;
    minimize-to-application = true;
    show-recents = false;
    tilesize = 48;
    static-only = false;
    show-process-indicators = true;
  };

  system.defaults.dock.persistent-apps = [
    "/Users/violette/Applications/Home Manager Apps/Google Chrome.app"
    "/Users/violette/Applications/Home Manager Apps/Warp.app"
    "/Users/violette/Applications/Home Manager Apps/Visual Studio Code.app"
    "/Users/violette/Applications/Home Manager Apps/Vesktop.app"
    "/Users/violette/Applications/Home Manager Apps/Youtube Music.app"
  ];

  networking = {
    hostName = "Saturn";
    computerName = "Saturn";
  };
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ]; 

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = 1; # Did you read the comment?

}
