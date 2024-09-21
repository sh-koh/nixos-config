{
  lib,
  modulesPath,
  ...
}:
{
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
  ];

  boot = {
    kernelModules = [ ];
    extraModulePackages = [ ];
    initrd = {
      availableKernelModules = [ "xhci_pci" "virtio_scsi" "sr_mod" ];
      kernelModules = [ ];
    };
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/41f54c37-06ee-40c7-a5e0-71df1d03c9b9";
      fsType = "ext4";
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/7548-C81D";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };
  };

  nixpkgs = {
    hostPlatform = lib.mkDefault "aarch64-linux";
    config.allowUnfree = true;
  };
  system.stateVersion = "24.05";
}
