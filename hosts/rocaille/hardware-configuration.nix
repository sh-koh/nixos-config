{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "ahci" "xhci_pci" "sd_mod" "sdhci_pci" "rtsx_usb_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/1d53668c-5c8a-4c8a-b7f1-139265d5eaeb";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."luks-9bb5b1e0-a554-44cf-9ddd-c23d08253002".device = "/dev/disk/by-uuid/9bb5b1e0-a554-44cf-9ddd-c23d08253002";

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/C733-69F0";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/f879075b-8c8b-4d26-a30e-c948ff7240fc"; }
    ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.bluetooth.enable = true;
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
