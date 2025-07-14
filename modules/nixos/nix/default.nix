{
  pkgs,
  config,
  lib,
  inputs,
  ...
}:
{
  nix =
    let
      flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
    in
    {
      package = pkgs.nixVersions.latest;
      registry = lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs;
      nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
      daemonCPUSchedPolicy = "idle";
      daemonIOSchedClass = "idle";
      channel.enable = false;
      settings = {
        flake-registry = "/etc/nix/registry.json";
        accept-flake-config = true;
        nix-path = config.nix.nixPath;
        use-cgroups = true;
        use-xdg-base-directories = true;
        auto-allocate-uids = true;
        auto-optimise-store = true;
        warn-dirty = false;
        extra-platforms = lib.mkForce config.boot.binfmt.emulatedSystems;
        builders-use-substitutes = true;
        preallocate-contents = true;
        #pure-eval = true; # FIXME: Home-manager news >:(
        keep-derivations = true;
        keep-outputs = true;
        always-allow-substitutes = true;
        allowed-users = [
          "shakoh"
          "@wheel"
        ];
        trusted-users = [
          "shakoh"
          "@wheel"
        ];
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
        experimental-features = [
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
    };
}
