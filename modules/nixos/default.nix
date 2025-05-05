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
    nvidia = ./nvidia;
    printing = ./printing;
    secrets = ./secrets;
    theme = ./theme;
    vfio = ./vfio;
  };
}
