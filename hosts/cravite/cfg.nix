{
  config,
  pkgs,
  lib,
  inputs,
  outputs,
  ...
}:
let
  inherit (inputs.self.lib.sshKeys.shakoh.toCravite) atrebois rocaille;
in
{
  boot.loader.efi.canTouchEfiVariables = lib.mkForce false;

  users.users.shakoh.openssh.authorizedKeys.keys = [ atrebois rocaille ];
}
