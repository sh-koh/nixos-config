{
  config,
  lib,
  pkgs,
  ...
}:
{
  boot = {
    binfmt.emulatedSystems = [ "aarch64-linux" ];
    supportedFilesystems = [ "ntfs" ];
    initrd.availableKernelModules = [
      "nvme"
      "xhci_pci"
      "ahci"
      "usbhid"
      "sd_mod"
    ];
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
      options = [
        "nofail"
        "noatime"
        "compress=zstd:3"
        "space_cache=v2"
        "ssd"
      ];
    };
    "/media/SSHD" = {
      device = "/dev/disk/by-label/SSHD";
      fsType = "btrfs";
      options = [
        "nofail"
        "noatime"
        "compress=zstd:3"
        "space_cache=v2"
      ];
    };
  };

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableAllFirmware;

  system.stateVersion = "23.05";
}
