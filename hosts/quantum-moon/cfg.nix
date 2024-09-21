{ lib, pkgs, inputs, ... }:
let
  inherit (inputs.self.lib.sshKeys.shakoh.toQuantumMoon) atrebois rocaille;
in
{
  boot.kernelPackages = lib.mkDefault pkgs.linuxKernel.packages.linux_hardened;
  networking = {
    hostName = "quantum-moon";
    useDHCP = lib.mkDefault true;
    firewall.enable = false; # Use Hetzner's firewall
  };
  users.users.shakoh.openssh.authorizedKeys.keys = [ atrebois rocaille ];
}
