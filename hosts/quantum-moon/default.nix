{
  config,
  mkNixos,
  withSystem,
  ...
}:
let
  inherit (config.flake) nixosModules;
in
{
  flake.nixosConfigurations.quantum-moon = withSystem "aarch64-linux" ({ ... }:
    mkNixos "aarch64-linux" [
      ./cfg.nix
      ./hw.nix

      nixosModules.docker
      nixosModules.nix
      nixosModules.notre-minecraft
    ]
  );
}
