{ pkgs
, lib
, config
, inputs
, outputs
, ...
}: {
  imports = [ inputs.agenix.nixosModules.default ];

  age.secrets = {
    vpn-eni-cfg = {
      file = "${inputs.nix-secrets}/vpn-eni-cfg.age";
      mode = "0400";
      owner = "root";
    };
    vpn-eni-crt = {
      file = "${inputs.nix-secrets}/vpn-eni-crt.age";
      mode = "0400";
      owner = "root";
    };
    vpn-eni-key = {
      file = "${inputs.nix-secrets}/vpn-eni-key.age";
      mode = "0400";
      owner = "root";
    };
    vpn-eni-up = {
      file = "${inputs.nix-secrets}/vpn-eni-up.age";
      mode = "0500";
      owner = "root";
    };
    eni-logins = {
      file = "${inputs.nix-secrets}/eni-logins.age";
      mode = "0400";
      owner = "root";
    };
  };
}
