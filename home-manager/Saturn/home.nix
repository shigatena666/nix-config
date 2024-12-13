{ inputs, outputs, lib, config, pkgs, username, ... }: {
  imports = [ ];

  home.username = username;
  home.homeDirectory = "/Users/${username}";
  
  nixpkgs.config.allowUnfree = true;

  systemd.user.services.sd-switch.enable = true;

  home.stateVersion = "23.05";
}
