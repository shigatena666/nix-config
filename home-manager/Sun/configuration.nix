{ config, pkgs, ... }:

{
    custom_dconf.enable = true;
    gaming.enable = true;
    generic.enable = true;
    generic.system.linux = true;
    messengers.enable = true;
    networking.enable = true;
    pentesting.enable = true;
    programming.enable = true;
    security.enable = true;
    storage.enable = true;
    theming.enable = true;
    virtualization.enable = true;

    nixpkgs.config.allowUnfree = true;
    nixpkgs.config.firefox.enableGnomeExtensions = true;

    services.desktopManager.cosmic.enable = true;
    services.displayManager.cosmic-greeter.enable = true;
}
