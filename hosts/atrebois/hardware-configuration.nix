{ config
, lib
, pkgs
, modulesPath
, ...
}: {
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "sd_mod" ];
  boot.supportedFilesystems = [ "ntfs" ];

  fileSystems."/" = {
    device = "/dev/disk/by-label/Root";
    fsType = "ext4";
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-label/Home";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/EFI-BOOT";
    fsType = "vfat";
  };

  fileSystems."/media/SSD" = {
    device = "/dev/disk/by-label/SSD";
    fsType = "btrfs";
  };

  fileSystems."/media/SSHD" = {
    device = "/dev/disk/by-label/SSHD";
    fsType = "btrfs";
  };

  hardware.nvidia = {
    modesetting.enable = true;
    nvidiaSettings = false;
    nvidiaPersistenced = true;
    powerManagement.enable = true;
    open = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware = {
    cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    bluetooth.enable = true;
    logitech.wireless.enable = true;
    opengl = {
      enable = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        nv-codec-headers-12
        vaapiVdpau
        libvdpau-va-gl
        libvdpau
        nvidia-vaapi-driver
        libva
        egl-wayland
      ];
    };
  };

  swapDevices = [ ];
  zramSwap.enable = true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
