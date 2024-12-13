{ config, pkgs, ... }: 

{
    programs.git.enable = true;
    nixpkgs.config.allowUnfree = true;
}
