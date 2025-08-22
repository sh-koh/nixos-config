{
  boot = {
    kernelModules = [ "kvm-intel" ];
    kernel.sysctl = {
      "rcutree.enable_rcu_lazy" = 1;
    };
    initrd.availableKernelModules = [
      "ahci"
      "xhci_pci"
      "usb_storage"
      "sd_mod"
      "sdhci_pci"
      "rtsx_usb_sdmmc"
    ];
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/ROOT";
      fsType = "ext4";

    };
    "/boot" = {
      device = "/dev/disk/by-label/BOOT";
      fsType = "vfat";
    };
  };

  system.stateVersion = "23.05";
}
