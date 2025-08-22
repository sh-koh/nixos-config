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
    config = "config ${config.vaultix.secrets.vpn-eni-cfg.path}";
    up = config.vaultix.secrets.vpn-eni-up.path;
    down = "${pkgs.openresolv}/sbin/resolvconf -d tun0";
  };

  vaultix = {
    secrets = with inputs; {
      vpn-eni-cfg = {
        file = inputs.self + /secrets/pro/vpn-eni-cfg.age;
        mode = "0400";
        owner = "root";
      };
      vpn-eni-crt = {
        file = inputs.self + /secrets/pro/vpn-eni-crt.age;
        mode = "0400";
        owner = "root";
      };
      vpn-eni-key = {
        file = inputs.self + /secrets/pro/vpn-eni-key.age;
        mode = "0400";
        owner = "root";
      };
      vpn-eni-up = {
        file = inputs.self + /secrets/pro/vpn-eni-up.age;
        mode = "0500";
        owner = "root";
      };
      eni-logins = {
        file = inputs.self + /secrets/pro/eni-logins.age;
        mode = "0400";
        owner = "root";
      };
    };
  };
}
