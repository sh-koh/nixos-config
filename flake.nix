{
  description = "Shakoh's NixOS and Home-manager flake";

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];

      imports = [
        ./hosts
        ./lib
        ./modules
        ./overlays
        ./pkgs
        ./users
      ];

      perSystem =
        { pkgs, self', ... }:
        {
          formatter = pkgs.nixfmt-rfc-style;
          devShells.default = pkgs.mkShellNoCC {
            inherit (self') formatter;
            name = "deployment-shell";
            stdenv.shell = pkgs.nushell;
            packages = with pkgs; [
              deadnix
              git
              just
              nushell
              statix
            ];
          };
        };
    };

  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://cuda-maintainers.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
    ];
  };

  inputs = {
    nixpkgs = {
      type = "github";
      owner = "NixOS";
      repo = "nixpkgs";
      ref = "nixos-unstable";
    };
    home-manager = {
      type = "github";
      owner = "nix-community";
      repo = "home-manager";
      ref = "master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts = {
      type = "github";
      owner = "hercules-ci";
      repo = "flake-parts";
      ref = "main";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    utils = {
      type = "github";
      owner = "sh-koh";
      repo = "nix-utils";
      ref = "main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mysecrets = {
      type = "git";
      url = "ssh://git@github.com/sh-koh/nix-secrets.git";
      ref = "main";
      shallow = true;
      flake = false;
    };
    # Dependencies (in alphabetical order)
    agenix = {
      type = "github";
      owner = "ryantm";
      repo = "agenix";
      ref = "main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ags = {
      type = "github";
      owner = "aylur";
      repo = "ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    anyrun = {
      type = "github";
      owner = "kirottu";
      repo = "anyrun";
      ref = "master";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
    };
    nixvim = {
      type = "github";
      owner = "nix-community";
      repo = "nixvim";
      ref = "main";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
    };
    raspberry-pi = {
      type = "github";
      owner = "nix-community";
      repo = "raspberry-pi-nix";
      ref = "master";
    };
    stylix = {
      type = "github";
      owner = "danth";
      repo = "stylix";
      ref = "master";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    xivlauncher-rb = {
      type = "github";
      owner = "drakon64";
      repo = "nixos-xivlauncher-rb";
      ref = "main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser-flake = {
      type = "github";
      owner = "youwen5";
      repo = "zen-browser-flake";
      ref = "master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
