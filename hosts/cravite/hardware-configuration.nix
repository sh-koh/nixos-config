{ config, lib, pkgs, modulesPath, inputs, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [ "usbhid" "usb_storage" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.kernelPackages = inputs.nix-rpi5.legacyPackages.aarch64-linux.linuxPackages_rpi5;
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/5727bbfc-f35c-43b8-a461-d0c921b1834e";
    fsType = "btrfs";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/022E-76E8";
    fsType = "vfat";
  };

  zramSwap.enable = true;
  swapDevices = [ ];

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = "aarch64-linux";
}
