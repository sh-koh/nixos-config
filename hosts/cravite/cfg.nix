{ inputs, ... }:
let
  inherit (inputs.self.lib.sshKeys.shakoh.toCravite) atrebois rocaille;
in
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
  users.users.shakoh.openssh.authorizedKeys.keys = [
    atrebois
    rocaille
  ];

  services.k3s = {
    enable = true;
  };
}
