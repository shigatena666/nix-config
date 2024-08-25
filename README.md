# Home Manager Configuration

This repository contains my own Home Manager configuration files and related NixOS modules.
It is heavily inspired by the advices of Vimjoyer on this repository : https://github.com/vimjoyer/modularize-video and https://github.com/Misterio77/nix-starter-configs/.

# Compiling Home

```
home-manager switch --flake .#saturn
home-manager switch --flake .#sun
```

# Compiling Nix

```
sudo nixos-rebuild switch
```

# SOPS

```
sops --encrypt --in-place --pgp PGP .secrets/secrets.yaml
sops --decrypt secrets.yaml
```

# dconf2nix

```
dconf dump / | dconf2nix > dconf.nix
```

# Mounted folder to Proton Drive using rclone

```
rclone mount proton: /home/violette/Proton/ --vfs-cache-mode full --allow-non-empty
```
