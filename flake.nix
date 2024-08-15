{
  description = "Shakoh's NixOS flake";
  inputs = {
    master = {
      type = "github";
      owner = "NixOS";
      repo = "nixpkgs";
      ref = "master";
    };
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
    home-manager = {
      type = "github";
      owner = "nix-community";
      repo = "home-manager";
      ref = "master";
      inputs.nixpkgs.follows = "unstable";
    };
    utils = {
      type = "github";
      owner = "sh-koh";
      repo = "nix-utils";
      ref = "main";
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
      #inputs.nixpkgs.follows = "unstable";
    };
    anyrun = {
      type = "github";
      owner = "kirottu";
      repo = "anyrun";
      ref = "master";
      inputs.nixpkgs.follows = "unstable";
    };
    ags = {
      type = "github";
      owner = "aylur";
      repo = "ags";
      ref = "main";
      inputs.nixpkgs.follows = "unstable";
    };
    umu = {
      type = "git";
      url = "https://github.com/Open-Wine-Components/umu-launcher";
      #rev = "89a49751ffbeeed0beeba21ee9ba7fd7c94ce78f"; # 0.1-RC4
      ref = "main";
      dir = "packaging/nix";
      submodules = true;
      inputs.nixpkgs.follows = "unstable";
    };
    agenix = {
      type = "github";
      owner = "ryantm";
      repo = "agenix";
      ref = "main";
      inputs.nixpkgs.follows = "unstable";
    };
    mysecrets = {
      type = "git";
      url = "ssh://git@github.com/sh-koh/nix-secrets.git";
      ref = "main";
      shallow = true;
      flake = false;
    };
  };

  outputs =
    {
      self,
      unstable,
      utils,
      ...
    }@inputs:
    let
      inherit (self) outputs;
    in
    {
      formatter = utils.lib.forAllSystems (sys: unstable.legacyPackages.${sys}.nixfmt-rfc-style);
      packages = utils.lib.forAllSystems (sys: import ./pkgs unstable.legacyPackages.${sys});
      overlays = import ./overlays { inherit inputs outputs; };
      nixosModules = import ./modules/nixos;
      homeManagerModules = import ./modules/home-manager;
      nixosConfigurations = {
        atrebois = unstable.lib.nixosSystem {
          modules = [ ./hosts/atrebois ];
          specialArgs = {
            inherit inputs outputs;
          };
        };
        rocaille = unstable.lib.nixosSystem {
          modules = [ ./hosts/rocaille ];
          specialArgs = {
            inherit inputs outputs;
          };
        };
        cravite = unstable.lib.nixosSystem {
          modules = [ ./hosts/cravite ];
          specialArgs = {
            inherit inputs outputs;
          };
        };
      };
    };
}
