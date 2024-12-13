{
  description = "shigatena's nix config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    cachix.url = "github:cachix/cachix";
  };

  outputs = { self, nixpkgs, home-manager, darwin, ... } @ inputs:
    let username = "violette";

    mkConfig = builder: system: host: extraModules:
      builder {
        specialArgs = { inherit inputs username host; inherit (self) outputs; };
        modules = [ ./nixos/${host}/configuration.nix ./pkgs ] ++ extraModules;
      };

    mkHomeConfig = system: host:
      home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        extraSpecialArgs = { inherit inputs username host; inherit (self) outputs; };
        modules = [
          ./home-manager/${host}/home.nix
          ./home-manager/${host}/configuration.nix
        ];
      };
  in {
    
    nixosConfigurations = {
      Sun = mkConfig nixpkgs.lib.nixosSystem "x86_64-linux" "Sun" [ home-manager.nixosModules.home-manager ];
      WSL = mkConfig nixpkgs.lib.nixosSystem "x86_64-linux" "WSL" [ home-manager.nixosModules.home-manager ];
    };

    darwinConfigurations = {
      Saturn = mkConfig darwin.lib.darwinSystem "aarch64-darwin" "Saturn" [ home-manager.darwinModules.home-manager ];
    };

    homeConfigurations = {
      "${username}@Sun" = mkHomeConfig "x86_64-linux" "Sun";
      "${username}@WSL" = mkHomeConfig "x86_64-linux" "WSL";
      "${username}@Saturn" = mkHomeConfig "aarch64-darwin" "Saturn";
    };
  };
}
