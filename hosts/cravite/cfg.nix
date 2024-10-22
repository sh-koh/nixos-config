{ inputs, ... }:
let
  inherit (inputs.self.lib.sshKeys.shakoh.toCravite) atrebois rocaille;
in
{
  boot = {
    tmp.useTmpfs = true;
    kernelParams = [ "mitigations=off" "spectre_v2=off" ];
  };

  users.users.shakoh.openssh.authorizedKeys.keys = [ atrebois rocaille ];
}
