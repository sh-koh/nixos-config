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

  networking = {
    hostName = "cravite";
    firewall = {
      interfaces = {
        wlan0 = {
          allowedTCPPorts = [ 6443 ];
          allowedTCPPortRanges = [
            # { from = x; to = x; }
          ];
          allowedUDPPorts = [ 6443 ];
          allowedUDPPortRanges = [
            # { from = x; to = x; }
          ];
        };
      };
    };
  };

  users.users.shakoh = {
    initialPassword = lib.mkForce "cravite";
    hashedPasswordFile = lib.mkForce null;
  };

  age.secrets = lib.mkForce { };

  services.k3s = {
    enable = true;
  };
}
