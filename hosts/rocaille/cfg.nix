{ inputs, pkgs, ... }:
let
  inherit (inputs.self.lib.sshKeys.shakoh.toRocaille) atrebois;
in
{
  networking.hostName = "rocaille";
  users.users.shakoh.openssh.authorizedKeys.keys = [ atrebois ];

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

  virtualisation.waydroid.enable = true;
}
