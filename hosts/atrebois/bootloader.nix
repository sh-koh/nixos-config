{ pkgs
, lib
, config
, inputs
, outputs
, ...
}: {
  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_zen;
    loader.efi.canTouchEfiVariables = true;
    loader.systemd-boot = {
      enable = true;
      consoleMode = "max";
    };
    kernelParams = [
      "mitigations=off"
      "spectre_v2=off"
      "nvidia-drm.fbdev=1"
    ];
    kernelModules = [
      "acpi-cpufreq"
      "nvidia"
      "nvidia_drm"
      "nvidia_uvm"
      "nvidia_modeset"
    ];
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
    tmp.useTmpfs = true;
  };
}
