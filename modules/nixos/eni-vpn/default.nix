{ config, pkgs, ... }:
{
  services.openvpn.servers.eni = {
    updateResolvConf = true;
    extraArgs = [ ];
    autoStart = false;
    config = "config ${config.age.secrets.vpn-eni-cfg.path}";
    up = config.age.secrets.vpn-eni-up.path;
    down = "${pkgs.openresolv}/sbin/resolvconf -d tun0";
  };
}
