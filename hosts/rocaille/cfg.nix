{
  inputs,
  pkgs,
  lib,
  ...
}:
{
  networking.hostName = "rocaille";

  boot = {
    tmp.useTmpfs = true;
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = true;
        consoleMode = "max";
      };
    };
    kernelPackages = pkgs.linuxKernel.packages.linux_zen;
    kernelParams = [
      "mitigations=off"
      "spectre_v2=off"
      "preempt=full"
    ];
    kernelModules = [ "acpi-cpufreq" ];
    kernel.sysctl = {
      "vm.max_map_count" = "1048576";
    };
  };

  users.users.shakoh.openssh.authorizedKeys.keys = lib.mapAttrsToList (
    _: v: v
  ) inputs.self.lib.pubKeys.ssh.shakoh.toRocaille;

  programs = {
    adb.enable = true;
    wireshark = {
      enable = true;
      package = pkgs.wireshark-qt;
    };
  };

  virtualisation.waydroid.enable = true;
}
