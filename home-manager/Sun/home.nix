# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
  ];

  nixpkgs = {
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  home = {
    username = "violette";
    homeDirectory = "/home/violette";
  };

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;

  home.file.".profile" = {
    source = ./../../.config/profile.jpg;
  };
    home.file.".background-image" = {
    source = ./../../.config/background.png;
  };

  home.file.".config/hypr" = {
    source = ./../../.config/hypr;
    recursive = true;
  };

  home.file.".config/rofi" = {
    source = ./../../.config/rofi;
    recursive = true;
  };

  home.file."/etc/uni-sync/uni-sync.json" = {
    source = ./../../.config/uni-sync/uni-sync.json;
    recursive = true;
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
