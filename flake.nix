{
  description = "Shakoh's NixOS flake";
  inputs = {
    unstable = {
      type = "github";
      owner = "NixOS";
      repo = "nixpkgs";
      ref = "nixos-unstable";
    };
    stable = {
      type = "github";
      owner = "NixOS";
      repo = "nixpkgs";
      ref = "nixos-24.05";
    };
    master = {
      type = "github";
      owner = "NixOS";
      repo = "nixpkgs";
      ref = "master";
    };
    hardware = {
      type = "github";
      owner = "nixos";
      repo = "nixos-hardware";
      ref = "master";
    };
    home-manager = {
      type = "github";
      owner = "nix-community";
      repo = "home-manager";
      ref = "master";
      inputs.nixpkgs.follows = "unstable";
    };
    stylix = {
      type = "github";
      owner = "danth";
      repo = "stylix";
      ref = "master";
      inputs.nixpkgs.follows = "unstable";
    };
    nixvim = {
      type = "github";
      owner = "nix-community";
      repo = "nixvim";
      ref = "main";
      inputs.nixpkgs.follows = "unstable";
    };
    anyrun = {
      type = "github";
      owner = "kirottu";
      repo = "anyrun";
      ref = "master";
    };
    ags = {
      type = "github";
      owner = "aylur";
      repo = "ags";
      ref = "main";
    };
    hyprland = {
      type = "github";
      owner = "hyprwm";
      repo = "hyprland";
      ref = "v0.40.0";
    };
    hyprsplit = {
      type = "github";
      owner = "shezdy";
      repo = "hyprsplit";
      ref = "v0.40.0";
      inputs.hyprland.follows = "hyprland";
    };
    umu = {
      type = "git";
      url = "https://github.com/Open-Wine-Components/umu-launcher";
      rev = "89a49751ffbeeed0beeba21ee9ba7fd7c94ce78f"; # 0.1-RC4
      dir = "packaging/nix";
      submodules = true;
      inputs.nixpkgs.follows = "unstable";
    };
    agenix = {
      type = "github";
      owner = "ryantm";
      repo = "agenix";
      ref = "main";
    };
    secrets = {
      type = "git";
      url = "ssh://git@github.com/sh-koh/nix-secrets.git";
      ref = "main";
      shallow = true;
      flake = false;
    };
  };

  outputs = { 
    self,
    unstable,
    ...
  }@inputs:
  let
    inherit (self) outputs;
    forAllSystems = unstable.lib.genAttrs [ "x86_64-linux" "aarch64-linux" ];
    mkNixos = modules:
      unstable.lib.nixosSystem {
        inherit modules;
        specialArgs = { inherit inputs outputs; };
      };
  in {
    packages = forAllSystems (system: import ./pkgs unstable.legacyPackages.${system});
    overlays = import ./overlays { inherit inputs outputs; };
    nixosModules = import ./modules/nixos;
    homeManagerModules = import ./modules/home-manager;
    nixosConfigurations = {
      atrebois = mkNixos [ ./hosts/atrebois ];
      rocaille = mkNixos [ ./hosts/rocaille ];
      cravite = mkNixos [ ./hosts/cravite ];
    };
  };
}
