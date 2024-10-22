{
  config,
  lib,
  ...
}:
{
  boot = {
    binfmt.emulatedSystems = [ "aarch64-linux" ];
    supportedFilesystems = [ "ntfs" ];
    initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "sd_mod" ];
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/Root";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-label/EFI-BOOT";
      fsType = "vfat";
    };
    "/home" = {
      device = "/dev/disk/by-label/Home";
      fsType = "ext4";
    };
    "/media/SSD" = {
      device = "/dev/disk/by-label/SSD";
      fsType = "btrfs";
    };
    "/media/SSHD" = {
      device = "/dev/disk/by-label/SSHD";
      fsType = "btrfs";
    };
  };

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  nixpkgs = {
    hostPlatform = "x86_64-linux";
    config = {
      allowUnfree = true;
      cudaSupport = true;
    };
  };
  system.stateVersion = "23.05";
}
