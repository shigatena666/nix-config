# Home Manager Configuration

This repository contains my own Home Manager configuration files and related NixOS modules.
It is heavily inspired by the advices of Vimjoyer on this repository : https://github.com/vimjoyer/modularize-video and https://github.com/Misterio77/nix-starter-configs/.

# Compiling Home

```
home-manager --flake .#your-username@your-hostname
```

Example:
```
home-manager switch --flake .#violette@Saturn
home-manager switch --flake .#violette@Sun
```

# Compiling Nix

```
sudo nixos-rebuild switch --flake .#your-hostname
```

Example: 
```
sudo nixos-rebuild switch --flake .#Saturn
sudo nixos-rebuild switch --flake .#Sun
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
