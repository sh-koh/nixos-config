{
  inputs,
  pkgs,
  lib,
  ...
}:
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
    kernel.sysctl = {
      "vm.max_map_count" = "1048576";
    };
  };

  networking = {
    hostName = "lune-quantique";
    useDHCP = lib.mkDefault true;
    firewall.enable = false; # Use Hetzner's firewall
  };

  users.users.shakoh.openssh.authorizedKeys.keys = lib.mapAttrsToList (
    _: v: v
  ) inputs.self.lib.pubKeys.ssh.shakoh.toLuneQuantique;
}
