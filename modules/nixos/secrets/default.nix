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
  };
}
