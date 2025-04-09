{ inputs, pkgs, ... }:
let
  inherit (inputs.self.lib.sshKeys.shakoh.toAtrebois) rocaille;
in
{
  users.users.shakoh.openssh.authorizedKeys.keys = [ rocaille ];

  networking = {
    hostName = "atrebois";
    firewall = {
      interfaces = {
        enp34s0 = {
          allowedTCPPorts = [ ];
          allowedTCPPortRanges = [
            # { from = x; to = x; }
          ];
          allowedUDPPorts = [ ];
          allowedUDPPortRanges = [
            # { from = x; to = x; }
          ];
        };
      };
    };
  };

  boot = {
    tmp.useTmpfs = true;
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = true;
        consoleMode = "max";
      };
    };
    kernelPackages = pkgs.linuxKernel.packages.linux_zen;
    kernelParams = [
      "mitigations=off"
      "spectre_v2=off"
      "preempt=full"
    ];
    kernelModules = [ "acpi-cpufreq" ];
    kernel.sysctl = {
      "vm.max_map_count" = "1048576";
    };
  };

  programs = {
    adb.enable = true;
    wireshark = {
      enable = true;
      package = pkgs.wireshark-qt;
    };
  };

  services = {
    nfs.server.enable = true;
    zerotierone = {
      enable = true;
      package = pkgs.zerotierone;
      joinNetworks = [ "52b337794fa1f40e" ];
    };
  };
}
