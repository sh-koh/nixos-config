{ lib, pkgs, ... }:
{
  hardware = {
    enableAllFirmware = lib.mkDefault true;
  };

  boot = {
    initrd.systemd.enable = true;
    kernelPackages =
      lib.mkDefault
        pkgs.linuxKernel.packages."linux_${lib.concatStringsSep "_" (lib.take 2 (lib.splitVersion pkgs.linuxKernel.kernels.linux_latest.version))}";
  };

  zramSwap.enable = true;

  services = {
    dbus = {
      enable = true;
      implementation = "broker";
    };
    fstrim.enable = true;
    fwupd.enable = true;
    gvfs.enable = true;
    upower.enable = true;
  };

  powerManagement.cpuFreqGovernor = "ondemand";

  services.openssh = {
    enable = true;
    startWhenNeeded = true;
    ports = [ 72 ];
    settings = {
      KbdInteractiveAuthentication = false;
      PasswordAuthentication = false;
      AllowUsers = [ "shakoh" ];
    };
  };
}
