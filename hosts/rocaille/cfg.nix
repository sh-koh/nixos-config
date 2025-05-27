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
    kernelModules = [ "acpi-cpufreq" ];
  };

  programs = {
    adb.enable = true;
    wireshark = {
      enable = true;
      package = pkgs.wireshark-qt;
    };
  };

  virtualisation.waydroid.enable = true;
}
