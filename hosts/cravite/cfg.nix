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
      "preempt=full"
    ];
  };

  networking.hostName = "cravite";

  services.k3s = {
    enable = true;
  };
}
