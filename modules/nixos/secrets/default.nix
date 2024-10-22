{
  inputs,
  ...
}:
{
  imports = [
    inputs.agenix.nixosModules.default
  ];

  age.identityPaths = [
    "/etc/ssh/ssh_host_rsa_key"
    "/etc/ssh/ssh_host_ed25519_key"
    "/home/shakoh/.ssh/id_secrets"
  ];

  age.secrets = with inputs; {
    shakoh-pwd = {
      file = "${mysecrets}/me/shakoh-pwd.age";
      mode = "0400";
      owner = "root";
    };
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
