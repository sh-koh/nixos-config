{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:
{

  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix") ];

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

  swapDevices = [ ];

  zramSwap.enable = true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  
  hardware = {
    cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    bluetooth.enable = true;
    logitech.wireless.enable = true;
    keyboard.qmk.enable = true;
    opentabletdriver.enable = true;
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [ vaapiVdpau libvdpau-va-gl libvdpau nvidia-vaapi-driver libva egl-wayland ];
    };
    nvidia = {
      package = lib.mkDefault config.boot.kernelPackages.nvidiaPackages.latest;
      modesetting.enable = true;
      nvidiaSettings = false;
      powerManagement.enable = true;
      open = true;
    };
  };
}
