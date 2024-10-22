{ inputs, pkgs, ... }:
let
  inherit (inputs.self.lib.sshKeys.shakoh.toAtrebois) rocaille;
in
{
  boot = {
    tmp.useTmpfs = true;
    loader.efi.canTouchEfiVariables = true;
    loader.systemd-boot = {
      enable = true;
      consoleMode = "max";
    };
    kernelPackages = pkgs.linuxKernel.packages.linux_zen;
    kernelParams = [ "mitigations=off" "spectre_v2=off" ];
    kernelModules = [ "acpi-cpufreq" ];
    kernel.sysctl = {
      "vm.max_map_count" = "1048576";
    };
  };

  networking.hostName = "atrebois";
  users.users.shakoh.openssh.authorizedKeys.keys = [ rocaille ];
}
