{ pkgs
, lib
, config
, inputs
, outputs
, ...
}: {
  imports = [ inputs.agenix.nixosModules.default ];

  age.identityPaths = [
    "/etc/ssh/ssh_host_rsa_key"
    "/home/shakoh/.ssh/id_secrets"
  ];

  age.secrets = {
    shakoh-pwd = {
      file = "${inputs.secrets}/me/shakoh-pwd.age";
      mode = "0400";
      owner = "root";
    };
  };

  age.secrets = {
    vpn-eni-cfg = {
      file = "${inputs.secrets}/pro/vpn-eni-cfg.age";
      mode = "0400";
      owner = "root";
    };
    vpn-eni-crt = {
      file = "${inputs.secrets}/pro/vpn-eni-crt.age";
      mode = "0400";
      owner = "root";
    };
    vpn-eni-key = {
      file = "${inputs.secrets}/pro/vpn-eni-key.age";
      mode = "0400";
      owner = "root";
    };
    vpn-eni-up = {
      file = "${inputs.secrets}/pro/vpn-eni-up.age";
      mode = "0500";
      owner = "root";
    };
    eni-logins = {
      file = "${inputs.secrets}/pro/eni-logins.age";
      mode = "0400";
      owner = "root";
    };
  };
}
