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
  flake.nixosConfigurations.atrebois = withSystem "x86_64-linux" ({ ... }:
    mkNixos "x86_64-linux" [
      ./cfg.nix
      ./hw.nix

      nixosModules.bluetooth
      nixosModules.desktop
      nixosModules.docker
      nixosModules.eni-vpn
      nixosModules.gaming
      nixosModules.nix
      nixosModules.nvidia
      nixosModules.printing
      nixosModules.vfio
    ]
  );
}
