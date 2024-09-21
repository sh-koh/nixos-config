{ lib, pkgs, ... }:
{
  hardware = {
    enableAllFirmware = lib.mkDefault true;
  };

  boot = {
    kernelParams = [ "mitigations=off" "spectre_v2=off" ];
    tmp.useTmpfs = true;
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = true;
        consoleMode = "keep";
      };
    };
  };

  zramSwap.enable = true;

  services = {
    dbus.enable = true;
    dbus.implementation = "broker";
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
