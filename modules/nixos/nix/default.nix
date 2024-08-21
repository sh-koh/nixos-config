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
      package = pkgs.nixVersions.nix_2_23;
      registry = lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs;
      nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
      settings = {
        flake-registry = "";
        nix-path = config.nix.nixPath;
        max-jobs = 8;
        use-cgroups = true;
        #use-xdg-base-directories = true;
        auto-allocate-uids = true;
        auto-optimise-store = true;
        builders-use-substitutes = true;
        allowed-users = [ "shakoh" ];
        experimental-features = [
          "auto-allocate-uids"
          "ca-derivations"
          "cgroups"
          "daemon-trust-override"
          "dynamic-derivations"
          "fetch-closure"
          "flakes"
          "impure-derivations"
          "nix-command"
          "no-url-literals"
          "parse-toml-timestamps"
          "read-only-local-store"
          "recursive-nix"
        ];
      };
    };
}
