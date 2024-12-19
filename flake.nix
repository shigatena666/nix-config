{
  description = "NixOS and nix-darwin configs for my machines";
  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # NixOS profiles to optimize settings for different hardware
    hardware.url = "github:nixos/nixos-hardware";

    # Nix Darwin (for MacOS machines)
    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Homebrew
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";

    # WSL
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";

    # Hyprpanel
    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";
  };

  outputs = {
    self,
    darwin,
    home-manager,
    nix-homebrew,
    nixos-wsl,
    hyprpanel,
    nixpkgs,
    ...
  } @ inputs: let
    inherit (self) outputs;

    # Define user configurations
    users = {
      violette = {
        avatar = ./files/avatar/face;
        email = "violette@shigatena.dev";
        fullName = "Violette";
        gitKey = "3962D5FE4DD1CD22";
        name = "violette";
      };
    };

    # Function for NixOS system configuration
    mkNixosConfiguration = hostname: username:
      nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs outputs hostname;
          userConfig = users.${username};
        };
        modules = [
          ./hosts/${hostname}/configuration.nix 
          ./pkgs
          nixos-wsl.nixosModules.default
        ];
      };

    # Function for nix-darwin system configuration
    mkDarwinConfiguration = hostname: username:
      darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = {
          inherit inputs outputs hostname;
          userConfig = users.${username};
        };
        modules = [
          ./hosts/${hostname}/configuration.nix
          home-manager.darwinModules.home-manager
          nix-homebrew.darwinModules.nix-homebrew
        ];
      };

    # Function for Home Manager configuration
    mkHomeConfiguration = system: username: hostname:
      home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            inputs.hyprpanel.overlay
          ];
        };
        extraSpecialArgs = {
          inherit inputs outputs;
          userConfig = users.${username};
        };
        modules = [
          ./home/${username}/${hostname}.nix
        ];
      };
  in {
    nixosConfigurations = {
      Sun = mkNixosConfiguration "Sun" "violette";
      WSL = mkNixosConfiguration "WSL" "violette";
    };

    darwinConfigurations = {
      "Saturn" = mkDarwinConfiguration "Saturn" "violette";
    };

    homeConfigurations = {
      "violette@Sun" = mkHomeConfiguration "x86_64-linux" "violette" "Sun";
      "violette@WSL" = mkHomeConfiguration "x86_64-linux" "violette" "WSL";
      "violette@Saturn" = mkHomeConfiguration "aarch64-darwin" "violette" "Saturn";
    };

    overlays = import ./overlays {inherit inputs;};
  };
}
