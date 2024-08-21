{ config, mkNixos, withSystem, ... }:
let
  inherit (config.flake) nixosModules;
in
{
  flake.nixosConfigurations.rocaille = withSystem "x86_64-linux" ({ ... }:
    mkNixos "x86_64-linux" [
      ./cfg.nix
      ./hw.nix

      nixosModules.bluetooth
      nixosModules.desktop
      nixosModules.docker
      nixosModules.eni-vpn
      nixosModules.intel
      nixosModules.nix
      nixosModules.printing
    ]);
}
