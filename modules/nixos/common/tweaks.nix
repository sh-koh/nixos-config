{ lib, ... }:
{
  hardware = {
    enableAllFirmware = lib.mkDefault true;
  };

  zramSwap.enable = true;

  services = {
    fstrim.enable = true;
    upower.enable = true;
    fwupd.enable = true;
    dbus = {
      enable = true;
      implementation = "broker";
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
      AllowUsers = [
        "shakoh"
      ];
    };
  };
}
