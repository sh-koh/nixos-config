{ lib, ... }:
{
  hardware = {
    enableAllFirmware = lib.mkDefault true;
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
      AllowUsers = [
        "shakoh"
      ];
    };
  };
}
