{
  lib,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    inputs.vaultix.nixosModules.default
    inputs.self.nixosModules.nushell
  ];

  hardware = {
    enableAllFirmware = true;
  };

  boot = {
    initrd.systemd.enable = true;
    kernel.sysctl = {
      "fs.file-max" = 2097152;
      "vm.swappiness" = 100;
      "vm.vfs_cache_pressure" = 50;
      "vm.dirty_bytes" = 268435456;
      "vm.page-cluster" = 0;
      "vm.dirty_background_bytes" = 67108864;
      "vm.dirty_writeback_centisecs" = 1500;
      "kernel.nmi_watchdog" = 0;
      "kernel.unprivileged_userns_clone" = 1;
      "kernel.printk" = "3 3 3 3";
      "kernel.kptr_restrict" = 2;
      "kernel.kexec_load_disabled" = 1;
      "net.core.netdev_max_backlog" = 4096;
    };
    kernelPackages =
      lib.mkDefault
        pkgs.linuxKernel.packages."linux_${lib.concatStringsSep "_" (lib.take 2 (lib.splitVersion pkgs.linuxKernel.kernels.linux_latest.version))}";
  };

  services.udev.packages = [
    (pkgs.writeTextFile {
      name = "sata-udev-rules";
      destination = "/etc/udev/rules.d/60-sata.rules";
      text = ''
        ACTION=="add", SUBSYSTEM=="scsi_host", KERNEL=="host*", \
            ATTR{link_power_management_policy}=="*", \
            ATTR{link_power_management_policy}="max_performance"
      '';
    })
    (pkgs.writeTextFile {
      name = "hdparm-udev-rules";
      destination = "/etc/udev/rules.d/69-hdparm.rules";
      text = ''
        ACTION=="add|change", KERNEL=="sd[a-z]", ATTR{queue/rotational}=="1", \
            RUN+="${lib.getExe pkgs.hdparm} -B 254 -S 0 /dev/%k"
      '';
    })
  ];

  zramSwap.enable = true;

  security.sudo.enable = false;
  security.sudo-rs = {
    enable = true;
    execWheelOnly = true;
  };

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

  users = {
    mutableUsers = false;
    users = {
      root = {
        uid = 0;
        home = "/root";
        hashedPassword = "!";
      };
    };
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

  services.userborn.enable = true;

  /*
    FIXME,TODO: It mounts a temporary filesystem on top of etc, hiding files
    located on the previously existant filesystem, so no more ssh keys
    in /etc/ssh. It might be useless if 'impermanence' is setup.
  */
  # system.etc.overlay.enable = true;

  system.tools.nixos-generate-config.enable = false;
  programs.less.lessopen = null;
  programs.command-not-found.enable = false;
  boot.loader.grub.enable = false;
  environment.defaultPackages = lib.mkForce [ ];
  documentation.info.enable = false;
  documentation.nixos.enable = false;
  services.orca.enable = false;
  services.speechd.enable = false;
}
