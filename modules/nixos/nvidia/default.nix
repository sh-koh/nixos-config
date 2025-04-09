{
  config,
  pkgs,
  lib,
  ...
}:
{
  boot = {
    kernelParams = [ "nvidia-drm.fbdev=1" ];
    kernelModules = [
      "nvidia"
      "nvidia_drm"
      "nvidia_modeset"
    ];
    extraModprobeConfig = ''
      options nvidia NVreg_UsePageAttributeTable=1
      options nvidia NVreg_PreserveVideoMemoryAllocations=1
      options nvidia NVreg_InitializeSystemMemoryAllocations=1
      options nvidia NVreg_EnableGpuFirmware=1
      options nvidia NVreg_EnablePCIeGen3=1
      options nvidia NVreg_EnableMSI=1
      #options nvidia NVreg_RegistryDwords="PowerMizerEnable=0x1; PowerMizerLevel=0x3; PowerMizerDefault=0x3; PowerMizerDefaultAC=0x3; PerfLevelSrc=0x3333; OverrideMaxPerf=0x1"
    '';
  };

  environment.variables = {
    GBM_BACKEND = "nvidia-drm";
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    __GL_SHADER_DISK_CACHE = "1";
    __GL_SYNC_DISPLAY_DEVICE = "DP-1";
    __GL_YIELD = "USLEEP";
    __GL_SYNC_TO_VBLANK = "1";
    __GL_GSYNC_ALLOWED = "1";
    __GL_VRR_ALLOWED = "1";
    __GL_DXVK_OPTIMIZATIONS = "1";
    __GL_ALLOW_UNOFFICIAL_PROTOCOL = "1";
    NVD_BACKEND = "direct";
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware = {
    nvidia-container-toolkit.enable =
      if config.virtualisation.podman.enable || config.virtualisation.docker.enable then true else false;
    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.beta;
      modesetting.enable = true;
      nvidiaSettings = false;
      powerManagement.enable = true;
      open = true;
    };
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        nv-codec-headers-12
        vaapiVdpau
        libvdpau-va-gl
        libvdpau
        libva
        egl-wayland
      ];
    };
  };

  systemd.services = {
    "nvidia-overclock" =
      let
        deps = with pkgs.python312Packages; [
          nvidia-ml-py
          pynvml
        ];
      in
      {
        description = "NVIDIA Overclock";
        serviceConfig = {
          Type = "oneshot";
        };
        script = lib.getExe (
          pkgs.writers.writePython3Bin "nvidia-overclock" { libraries = deps; } ''
            import pynvml as nv
            nv.nvmlInit()
            myGPU = nv.nvmlDeviceGetHandleByIndex(0)
            nv.nvmlDeviceSetPowerManagementLimit(myGPU, 200000)
            nv.nvmlDeviceSetGpcClkVfOffset(myGPU, 140)
            nv.nvmlDeviceSetMemClkVfOffset(myGPU, 1200)
          ''
        );
      };
  };

  nixpkgs.config.cudaSupport = true;
}
