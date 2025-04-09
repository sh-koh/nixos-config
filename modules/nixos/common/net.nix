{ config, lib, ... }:
{
  boot = {
    kernelModules = [ "tcp_bbr" ];
    kernel.sysctl."net.ipv4.tcp_congestion_control" = "bbr";
  };

  environment.variables = {
    HOSTNAME = config.networking.hostName;
  };

  services.resolved = {
    enable = true;
    dnsovertls = "opportunistic";
  };

  networking = {
    wireless.enable = false;
    dhcpcd.enable = false;
    resolvconf.enable = false;
    enableIPv6 = false;
    useNetworkd = true;
    useDHCP = false;
    #nftables.enable = true; # TEST
    networkmanager = {
      enable = true;
      dns = "systemd-resolved";
      dhcp = "internal";
      ethernet = {
        macAddress = "stable";
      };
      wifi = {
        scanRandMacAddress = true;
        macAddress = "stable";
        backend = "iwd";
        powersave = true;
      };
      plugins = lib.mkForce [ ];
    };
  };

  # FIXME: Hangs, making rebuild fail
  systemd.services.systemd-networkd-wait-online.enable = false;
  systemd.services.NetworkManager-wait-online.enable = false;
  systemd.network.wait-online.enable = false;
  systemd.network.wait-online.anyInterface = false;
}
