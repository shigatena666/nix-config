# Home Manager Configuration

This repository contains my own Home Manager configuration files and related NixOS modules.
It is heavily inspired by the advices of Vimjoyer on this repository : https://github.com/vimjoyer/modularize-video and https://github.com/Misterio77/nix-starter-configs/.

# Install

## Nix

```
sh <(curl -L https://nixos.org/nix/install)
```

## home-manager

```
nix-shell -p home-manager

home-manager switch --extra-experimental-features nix-command --extra-experimental-features flakes --flake .#your-username@your-hostname
```

## Darwin

### Initial

```
nix run nix-darwin --extra-experimental-features nix-command --extra-experimental-features flakes -- switch --flake .#your-hostname
```

### Once installed

```
darwin-rebuild switch --flake .#your-hostname
```

## Nix

```
sudo nixos-rebuild switch --flake .#your-hostname
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
