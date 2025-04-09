{
  lib,
  pkgs,
  inputs,
  ...
}:
let
  inherit (inputs.self.lib.sshKeys.shakoh.toLuneQuantique) atrebois rocaille;
in
{
  boot = {
    tmp.useTmpfs = true;
    loader.efi.canTouchEfiVariables = true;
    loader.systemd-boot = {
      enable = true;
    };
    kernelPackages = lib.mkDefault pkgs.linuxKernel.packages.linux_hardened;
    kernelParams = [
      "mitigations=off"
      "spectre_v2=off"
    ];
    kernelModules = [ "acpi-cpufreq" ];
    kernel.sysctl = {
      "vm.max_map_count" = "1048576";
    };
  };

  networking = {
    hostName = "lune-quantique";
    useDHCP = lib.mkDefault true;
    firewall.enable = false; # Use Hetzner's firewall
  };
  users.users.shakoh.openssh.authorizedKeys.keys = [
    atrebois
    rocaille
  ];
}
