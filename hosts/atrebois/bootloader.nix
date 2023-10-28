{ pkgs
, lib
, config
, inputs
, outputs
, ...
}: {
  boot = {
    loader.systemd-boot.enable = true;
    loader.systemd-boot.consoleMode = "max";
    loader.efi.canTouchEfiVariables = true;
    kernelPackages = pkgs.linuxKernel.packages.linux_xanmod_latest;
    kernelParams = [ "mitigations=off" "spectre_v2=off" ];
    kernelModules = [ "acpi-cpufreq" ];
    extraModprobeConfig = ''
      options nvidia NVreg_UsePageAttributeTable=1
      options nvidia NVreg_PreserveVideoMemoryAllocations=1
      options nvidia NVreg_InitializeSystemMemoryAllocations=1
      options nvidia NVreg_EnableGpuFirmware=1
      options nvidia NVreg_EnablePCIeGen3=1
      options nvidia NVreg_EnableMSI=1
      options nvidia NVreg_RegistryDwords="PowerMizerEnable=0x1; PowerMizerLevel=0x3; PowerMizerDefault=0x3; PowerMizerDefaultAC=0x3; PerfLevelSrc=0x3333; OverrideMaxPerf=0x1"
    '';
    blacklistedKernelModules = [ "nouveau" "wacom" ];
    kernel.sysctl  = { "vm.max_map_count" = "16777216"; };
  };
}
