{ lib, pkgs, ... }:
{
  hardware = {
    enableAllFirmware = lib.mkDefault true;
  };

  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_zen;
    loader.efi.canTouchEfiVariables = true;
    loader.systemd-boot = {
      enable = true;
      consoleMode = "max";
    };
    kernelParams = [
      "mitigations=off"
      "spectre_v2=off"
    ];
    kernelModules = [
      "acpi-cpufreq"
    ];
    kernel.sysctl = {
      "vm.max_map_count" = "16777216";
    };
    tmp.useTmpfs = true;
  };

  zramSwap.enable = true;

  services = {
    dbus.enable = true;
    dbus.implementation = "broker";
    fstrim.enable = true;
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
      AllowUsers = [
        "shakoh"
      ];
    };
  };
}
