{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        pipx
        xorg.xhost
    ];

   system.activationScripts.installExegol = {
        text = ''
            ${pkgs.python3Packages.pipx}/bin/pipx install exegol
            ${pkgs.python3Packages.pipx}/bin/pipx ensurepath
        '';
  };
}
