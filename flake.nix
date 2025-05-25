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
        inputs.vaultix.flakeModules.default
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
            stdenv.shell = pkgs.bash;
            packages = with pkgs; [
              deadnix
              git
              just
              statix
            ];
          };
        };

      flake = {
        vaultix = {
          identity = "/home/shakoh/.ssh/id_secrets_new";
          extraRecipients = [ ];
          defaultSecretDirectory = "./secrets";
          cache = "./secrets/.cache";
          nodes = inputs.self.nixosConfigurations;
          extraPackages = [ ];
        };
        sshKeys = {
          secrets = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL2z8hygqaNYhnnm0xucyHWsBNcMQO8ofg5uJq43N4+s";
          shakoh =
            let
              atreboisKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAo4dwuiL8j7itIdLUOvSt89UhjT4DvQYYBPqf0QVIGB";
              rocailleKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJSMD7TLNxz5Xmtf5Dcnud+j5TJqQCHnWLXrDoRM3aFT";
              craviteKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKyeR3fIMoNYzIn1fGdZR9ZPhaF5kuQyzjomqIYqPLkk";
              # lanterneKey = "";
              # leviatheKey = "";
              # sabliereRougeKey = "";
              # sabliereNoireKey = "";
              # sombronceKey = "";
              # luneQuantiqueKey = "";
            in
            {
              atrebois = { inherit rocailleKey; };
              rocaille = { inherit atreboisKey; };
              cravite = { inherit atreboisKey rocailleKey; };
            };
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
    ags = {
      type = "github";
      owner = "aylur";
      repo = "ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    anyrun = {
      type = "github";
      owner = "anyrun-org";
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
    pogit = {
      type = "github";
      owner = "y-syo";
      repo = "pogit";
      ref = "master";
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
      owner = "nix-community";
      repo = "stylix";
      ref = "master";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    vaultix = {
      type = "github";
      owner = "milieuim";
      repo = "vaultix";
      ref = "main";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
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
