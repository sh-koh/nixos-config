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
        inputs.flake-parts.flakeModules.easyOverlay
        inputs.home-manager.flakeModules.home-manager
        inputs.vaultix.flakeModules.default
        ./hosts
        ./lib
        ./modules
        ./overlays
        ./pkgs
        ./users
        ./secrets
      ];

      perSystem =
        {
          pkgs,
          self',
          inputs',
          ...
        }:
        {
          formatter = pkgs.nixfmt-rfc-style;
          devShells.default = pkgs.mkShellNoCC {
            inherit (self') formatter;
            name = "deployment-shell";
            stdenv.shell = pkgs.bash;
            packages = with pkgs; [
              nixVersions.latest
              deadnix
              git
              just
              nurl
              statix
              inputs'.home-manager.packages.home-manager
            ];
          };
        };
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
      ref = "master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Dependencies (in alphabetical order)
    ags = {
      type = "github";
      owner = "aylur";
      repo = "ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri = {
      type = "github";
      owner = "sodiboo";
      repo = "niri-flake";
      ref = "main";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        nixpkgs-stable.follows = "nixpkgs";
      };
    };
    nixvim = {
      type = "github";
      owner = "nix-community";
      repo = "nixvim";
      ref = "main";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
      };
    };
    raspberry-pi = {
      /*
        TODO: raspberry-pi-nix is deprecated, a migration to
        [nixos-raspberrypi](https://github.com/nvmd/nixos-raspberrypi)
        is needed.
      */
      /*
        type = "github";
        owner = "nvmd";
        repo = "nixos-raspberrypi";
        ref = "develop";
      */
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
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
      };
    };
    vaultix = {
      type = "github";
      owner = "milieuim";
      repo = "vaultix";
      ref = "main";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
      };
    };
    zen-browser-flake = {
      type = "github";
      owner = "youwen5";
      repo = "zen-browser-flake";
      ref = "master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  nixConfig = {
    accept-flake-config = true;
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://cuda-maintainers.cachix.org"
      "https://niri.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
      "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
    ];
    extra-experimental-features = [
      "auto-allocate-uids"
      "ca-derivations"
      "cgroups"
      "configurable-impure-env"
      "daemon-trust-override"
      "dynamic-derivations"
      "fetch-closure"
      "fetch-tree"
      "flakes"
      "git-hashing"
      "impure-derivations"
      "local-overlay-store"
      "mounted-ssh-store"
      "nix-command"
      "no-url-literals"
      "parse-toml-timestamps"
      "pipe-operators"
      "read-only-local-store"
      "recursive-nix"
      "verified-fetches"
    ];
  };
}
