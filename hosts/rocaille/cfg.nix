{
  config,
  pkgs,
  lib,
  inputs,
  outputs,
  ...
}:
let
  inherit (inputs.self.lib.sshKeys.shakoh.toRocaille) atrebois;
in
{
  networking.hostName = "rocaille";
  users.users.shakoh.openssh.authorizedKeys.keys = [ atrebois ];
}
