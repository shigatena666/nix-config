{
  description = "My new nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    # Catppuccin
    catppuccin.url = "github:catppuccin/nix";

    # Home manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    catppuccin,
    home-manager,
    darwin,
    ...
  } @ inputs: let
    inherit (self) outputs;
    # Supported systems for your flake packages, shell, etc.
    systems = [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];
    # This is a function that generates an attribute by calling a function you
    # pass to it, with each system as an argument
    forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    # Formatter for your nix files, available through 'nix fmt'
    # Other options beside 'alejandra' include 'nixpkgs-fmt'
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    # NixOS configuration entrypoint
    nixosConfigurations = {
      
      # Available through 'nixos-rebuild --flake .#Sun'
      Sun = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          # > Our main nixos configuration file <
          ./nixos/Sun/configuration.nix
          catppuccin.nixosModules.catppuccin
        ];
      };

      # Available through 'nixos-rebuild --flake .#WSL'
      WSL = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          # > Our main nixos configuration file <
          ./nixos/WSL/configuration.nix
        ];
      };
    };

    darwinConfigurations = {
      Saturn = darwin.lib.darwinSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          # > Our main nixos configuration file <
          ./darwin/Saturn/configuration.nix
        ];
    };

    # Standalone home-manager configuration entrypoint
    homeConfigurations = {

      # Available through 'home-manager --flake .#violette@Sun'
      "violette@Sun" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
          extraSpecialArgs = {inherit inputs outputs;};
          modules = [
            # > Our main home-manager configuration file <
            ./home-manager/Sun/home.nix
            ./home-manager/Sun/configuration.nix
            ./pkgs
            catppuccin.homeManagerModules.catppuccin
          ];
        };
      };

      # Available through 'home-manager --flake .#violette@WSL'
      "violette@WSL" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = {inherit inputs outputs;};
        modules = [
          # > Our main home-manager configuration file <
          ./home-manager/WSL/home.nix
          ./home-manager/WSL/configuration.nix
          ./pkgs
          catppuccin.homeManagerModules.catppuccin
        ];
      };

      # Available through 'home-manager --flake .#violette@Saturn'
      "violette@Saturn" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.aarch64-darwin; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = {inherit inputs outputs;};
        modules = [
          # > Our main home-manager configuration file <
          ./home-manager/Saturn/home.nix
          ./home-manager/Saturn/configuration.nix
          ./pkgs
          catppuccin.homeManagerModules.catppuccin
        ];
      };
    };
  };
}
