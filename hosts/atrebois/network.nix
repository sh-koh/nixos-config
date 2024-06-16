{ pkgs, config, ... }:
{
  networking = {
    hostName = "atrebois";
    networkmanager.enable = true;
    wireless.enable = false;
    enableIPv6 = false;
  };

  networking.firewall = {
    enable = true;
    #interfaces.enp34s0 = {
    #  allowedUDPPorts = [ 9999 ];
    #  allowedTCPPorts = [ 9999 ];
    #};
    #interfaces.ztfp6jndkb = {
    #  allowedUDPPorts = [ 9999 ];
    #  allowedTCPPorts = [ 9999 ];
    #};
  };

  services.openvpn.servers.eni = {
    updateResolvConf = true;
    autoStart = false;
    config = "config ${config.age.secrets.vpn-eni-cfg.path}";
    up = config.age.secrets.vpn-eni-up.path;
    down = "${pkgs.openresolv}/sbin/resolvconf -d tun0";
  };

  services = {
    zerotierone = {
      enable = true;
      joinNetworks = [ "52b337794fa1f40e" ];
    };
    printing = {
      enable = true;
      drivers = [ pkgs.epson-escpr ];
    };
  };
}
