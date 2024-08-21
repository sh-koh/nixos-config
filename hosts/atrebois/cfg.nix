{ inputs, ... }:
let
  inherit (inputs.self.lib.sshKeys.shakoh.toAtrebois) rocaille;
in
{
  networking.hostName = "atrebois";
  users.users.shakoh.openssh.authorizedKeys.keys = [ rocaille ];
}
