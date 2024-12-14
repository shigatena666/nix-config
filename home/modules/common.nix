{outputs, ...}: {
  imports = [
    ../modules/fastfetch.nix
    ../modules/git.nix
    ../modules/go.nix
    ../modules/gpg.nix
    ../modules/home.nix
    ../modules/scripts.nix
  ];

  # Nixpkgs configuration
  nixpkgs = {
    overlays = [
      outputs.overlays.stable-packages
    ];

    config = {
      allowUnfree = true;
    };
  };
}
