{
  lib,
  pkgs,
  ...
}:
{
  hardware = {
    enableAllFirmware = lib.mkDefault true;
  };

  boot = {
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

  # Perlless
  boot.initrd.systemd.enable = lib.mkDefault true;
  system.etc.overlay.enable = lib.mkDefault true;
  services.userborn.enable = lib.mkDefault true;
  system.tools.nixos-generate-config.enable = lib.mkDefault false;
  programs.less.lessopen = lib.mkDefault null;
  programs.command-not-found.enable = lib.mkDefault false;
  boot.enableContainers = lib.mkDefault false;
  boot.loader.grub.enable = lib.mkDefault false;
  environment.defaultPackages = lib.mkDefault [ ];
  documentation.info.enable = lib.mkDefault false;
  documentation.nixos.enable = lib.mkDefault false;
}
