{ pkgs, config, ... }:
{
  networking = {
    hostName = "rocaille";
    networkmanager.enable = true;
    wireless.enable = false;
    enableIPv6 = false;
  };

  networking.firewall = {
    enable = true;
  };

  services.openvpn.servers.eni = {
    updateResolvConf = true;
    autoStart = false;
    config = "config ${config.age.secrets.vpn-eni-cfg.path}";
    up = config.age.secrets.vpn-eni-up.path;
    down = "${pkgs.openresolv}/sbin/resolvconf -d tun0";
  };

  services = {
    printing = {
      enable = true;
      drivers = [ pkgs.epson-escpr ];
    };
  };
}
