{ pkgs, ... }:
{
  boot = {
    loader.systemd-boot.enable = true;
    loader.systemd-boot.consoleMode = "max";
    loader.efi.canTouchEfiVariables = true;
    kernelPackages = pkgs.linuxKernel.packages.linux_zen;
    kernelParams = [
      "mitigations=off"
      "spectre_v2=off"
    ];
    kernel.sysctl = {
      "vm.max_map_count" = "16777216";
    };
  };
}
