{
  config,
  pkgs,
  inputs,
  ...
}:
{
  services.openvpn.servers.eni = {
    updateResolvConf = true;
    autoStart = false;
    config = "config ${config.age.secrets.vpn-eni-cfg.path}";
    up = config.age.secrets.vpn-eni-up.path;
    down = "${pkgs.openresolv}/sbin/resolvconf -d tun0";
  };

  age.secrets = with inputs; {
    vpn-eni-cfg = {
      file = "${mysecrets}/pro/vpn-eni-cfg.age";
      mode = "0400";
      owner = "root";
    };
    vpn-eni-crt = {
      file = "${mysecrets}/pro/vpn-eni-crt.age";
      mode = "0400";
      owner = "root";
    };
    vpn-eni-key = {
      file = "${mysecrets}/pro/vpn-eni-key.age";
      mode = "0400";
      owner = "root";
    };
    vpn-eni-up = {
      file = "${mysecrets}/pro/vpn-eni-up.age";
      mode = "0400";
      owner = "root";
    };
    eni-logins = {
      file = "${mysecrets}/pro/eni-logins.age";
      mode = "0400";
      owner = "root";
    };

  };
}
