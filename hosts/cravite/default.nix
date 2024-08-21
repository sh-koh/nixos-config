{ config, mkNixos, withSystem, ... }:
let
  inherit (config.flake) nixosModules;
in
{
  flake.nixosConfigurations.cravite = withSystem "aarch64-linux" ({ ... }:
    mkNixos "aarch64-linux" [
      ./cfg.nix
      ./hw.nix

      nixosModules.bluetooth
      nixosModules.docker
      nixosModules.nix
    ]);
}
