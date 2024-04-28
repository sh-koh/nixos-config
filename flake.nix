{
  description = "Shakoh's nixos configuration flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:nixos/nixpkgs";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix"; 
    nixvim.url = "github:nix-community/nixvim";
    anyrun.url = "github:kirottu/anyrun";
    ags.url = "github:aylur/ags";
    hyprland.url = "github:hyprwm/Hyprland/fe7b748eb668136dd0558b7c8279bfcd7ab4d759";
    smw = {
      url = "github:Duckonaut/split-monitor-workspaces/b0ee3953eaeba70f3fba7c4368987d727779826a";
      inputs.hyprland.follows = "hyprland";
    };
    
    agenix.url = "github:ryantm/agenix";
    nix-secrets = {
      url = "git+ssh://git@github.com/sh-koh/nix-secrets.git?shallow=1";
      flake = false;
    };

    umu = {
      url = "git+https://github.com/Open-Wine-Components/umu-launcher/?dir=packaging\/nix&submodules=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # For RPi 5 
    nix-rpi5.url = "gitlab:vriska/nix-rpi5";
  };

  nixConfig = {
    builders-use-substitutes = true;
    extra-substituters = [
      "https://anyrun.cachix.org"
      "https://nix-community.cachix.org"
      "https://ags.cachix.org"
    ];
    extra-trusted-public-keys = [
      "anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "ags.cachix.org-1:naAvMrz0CuYqeyGNyLgE010iUiuf/qx6kYrUv3NwAJ8="
    ];
  };

  outputs = { self, nixpkgs, ... }@inputs:
  let
    inherit (self) outputs;
    systems = [
      "x86_64-linux"
      "aarch64-linux"
      "riscv64-linux"
      "i686-linux"
    ];
    forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
    overlays = import ./overlays { inherit inputs; };
    nixosModules = import ./modules/nixos;
    homeManagerModules = import ./modules/home-manager;

    nixosConfigurations = {
      # Main machine
      atrebois = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs outputs; };
        modules = [ ./hosts/atrebois ];
      };
      # Laptop
      rocaille = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs outputs; };
        modules = [ ./hosts/rocaille ];
      };
      # Raspberry pi 5 
      cravite = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs outputs; };
        modules = [ ./hosts/cravite ];
      };
      #lanterne = nixpkgs.lib.nixosSystem {
      #  specialArgs = { inherit inputs outputs; };
      #  modules = [ ./hosts/lanterne ];
      #};
      #sombronces = nixpkgs.lib.nixosSystem {
      #  specialArgs = { inherit inputs outputs; };
      #  modules = [ ./hosts/sombronces ];
      #};
      #leviathe = nixpkgs.lib.nixosSystem {
      #  specialArgs = { inherit inputs outputs; };
      #  modules = [ ./hosts/leviathe ];
      #};
      #sabliere-noire = nixpkgs.lib.nixosSystem {
      #  specialArgs = { inherit inputs outputs; };
      #  modules = [ ./hosts/sabliere-noire ];
      #};
      #sabliere-rouge = nixpkgs.lib.nixosSystem {
      #  specialArgs = { inherit inputs outputs; };
      #  modules = [ ./hosts/sabliere-rouge ];
      #};
    };
  };
}
