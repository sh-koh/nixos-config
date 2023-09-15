{
  description = "Shakoh's nixos configuration flake";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Nix gaming
    nix-gaming.url = "github:fufexan/nix-gaming";

    # Nix User Repository
    nur.url = "github:nix-community/NUR";

    # Stylix
    stylix.url = "github:danth/stylix";

    # NixVim
    nixvim.url = "github:nix-community/nixvim";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Elkowar's EWW + temporary workaround rust-overlay: https://github.com/elkowar/eww/issues/817
    eww.url = "github:patrickshaw/eww";
    eww.inputs.nixpkgs.follows = "nixpkgs";

    # Hyprland and hyprsome
    hyprsome.url = "github:sopa0/hyprsome";
    hyprland.url = "github:hyprwm/hyprland";

    anyrun = {
      url = "github:kirottu/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  nixConfig = {
    builders-use-substitutes = true;
    extra-substituters = [
      "https://nix-gaming.cachix.org"
      "https://hyprland.cachix.org"
      "https://anyrun.cachix.org"
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  outputs = {
    self
  , nixpkgs
  , nix-gaming
  , dipc
  , nur
  , stylix
  , nixvim
  , home-manager
  , eww
  , rust-overlay
  , hyprsome
  , hyprland
  , anyrun
  , ...
  } @inputs:
  let
      inherit (self) outputs;
      forAllSystems = nixpkgs.lib.genAttrs [
        "aarch64-linux"
        "i686-linux"
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
    in
    rec {
      # Your custom packages
      # Accessible through 'nix build', 'nix shell', etc
      packages = forAllSystems (system:
        let pkgs = nixpkgs.legacyPackages.${system};
        in import ./pkgs { inherit pkgs; }
        );

      # Devshell for bootstrapping
      # Acessible through 'nix develop' or 'nix-shell' (legacy)
      devShells = forAllSystems (system:
        let pkgs = nixpkgs.legacyPackages.${system};
        in import ./shell.nix { inherit pkgs; }
        );

      # Your custom packages and modifications, exported as overlays
      overlays = import ./overlays { inherit inputs; };
      # Reusable nixos modules you might want to export
      # These are usually stuff you would upstream into nixpkgs
      nixosModules = import ./modules/nixos;
      # Reusable home-manager modules you might want to export
      # These are usually stuff you would upstream into home-manager
      homeManagerModules = import ./modules/home-manager;

      # NixOS configuration entrypoint
      # Available through 'nixos-rebuild --flake .#your-hostname'
      nixosConfigurations = {
        atrebois = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [
            ./hosts/atrebois/default.nix
          ];
        };
        rocaille = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [
            ./hosts/rocaille/default.nix
          ];
        };
      };
    };
}
