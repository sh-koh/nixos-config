{ inputs, lib, ... }:
{
  boot = {
    tmp = {
      useTmpfs = false;
      cleanOnBoot = true;
    };
    kernelParams = [
      "mitigations=off"
      "spectre_v2=off"
      "cgroup_memory=1"
      "cgroup_enable=memory"
    ];
  };

  networking.hostName = "cravite";
  users.users.shakoh.openssh.authorizedKeys.keys = lib.mapAttrsToList (
    _: v: v
  ) inputs.self.lib.pubKeys.ssh.shakoh.toCravite;

  services.k3s = {
    enable = true;
  };
}
