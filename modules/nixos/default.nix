{ ... }:
{
  flake.nixosModules = {
    bluetooth = ./bluetooth;
    common = ./common;
    desktop = ./desktop;
    docker = ./docker;
    eni-vpn = ./eni-vpn;
    gaming = ./gaming;
    intel = ./intel;
    nix = ./nix;
    notre-minecraft = ./notre-minecraft;
    nvidia = ./nvidia;
    printing = ./printing;
    secrets = ./secrets;
    vfio = ./vfio;
  };
}
