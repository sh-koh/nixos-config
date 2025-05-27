{
  inputs,
  pkgs,
  lib,
  ...
}:
{
  networking = {
    hostName = "atrebois";
    firewall = {
      interfaces = {
        enp34s0 = {
          allowedTCPPorts = [ ];
          allowedTCPPortRanges = [
            # { from = x; to = x; }
          ];
          allowedUDPPorts = [ ];
          allowedUDPPortRanges = [
            # { from = x; to = x; }
          ];
        };
      };
    };
  };

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

  services = {
    nfs.server.enable = true;
    zerotierone = {
      enable = true;
      package = pkgs.zerotierone;
      joinNetworks = [ "52b337794fa1f40e" ];
    };
  };
}
