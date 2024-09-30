{ config, pkgs, ... }:

{
    custom_dconf.enable = false;
    gaming.enable = false;
    generic.enable = true;
    generic.system.mac = true;
    messengers.enable = true;
    networking.enable = true;
    pentesting.enable = true;
    programming.enable = true;
    security.enable = true;
    storage.enable = true;
    theming.enable = false;
    virtualization.enable = false;

    nixpkgs.config.allowUnfree = true;
}
