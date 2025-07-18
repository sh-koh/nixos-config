{
  lib,
  pkgs,
  inputs,
  ...
}:
{
  hardware = {
    enableAllFirmware = true;
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

  system = {
    rebuild.enableNg = true;
  };

  system.tools.nixos-generate-config.enable = false;
  programs.less.lessopen = null;
  programs.command-not-found.enable = false;
  boot.loader.grub.enable = false;
  environment.defaultPackages = lib.mkForce [ ];
  documentation.info.enable = false;
  documentation.nixos.enable = false;
  services.orca.enable = false;
  services.speechd.enable = false;
  services.userborn.enable = true;

  /*
    FIXME,TODO: It mounts a temporary filesystem on top of etc, hiding files
    located on the previously existant filesystem, so no more ssh keys
    in /etc/ssh. It might be useless if 'impermanence' is setup.
  */
  # system.etc.overlay.enable = true;
}
