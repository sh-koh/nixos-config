{ config, pkgs, ... }:
{
  boot = {
    kernelParams = [ "nvidia-drm.fbdev=1" ];
    kernelModules = [
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
    blacklistedKernelModules = [
      "nouveau"
    ];
  };

  environment.variables = {
    GBM_BACKEND = "nvidia-drm";
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    __GL_SYNC_DISPLAY_DEVICE = "DP-1";
    __GL_YIELD = "USLEEP";
    __GL_GSYNC_ALLOWED = "1";
    __GL_VRR_ALLOWED = "1";
    __GL_DXVK_OPTIMIZATIONS = "1";
    __GL_ALLOW_UNOFFICIAL_PROTOCOL = "1";
    NVD_BACKEND = "direct";
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware = {
    nvidia-container-toolkit.enable = true;
    nvidia = {
      modesetting.enable = true;
      nvidiaSettings = false;
      powerManagement.enable = true;
      open = true;
      package = config.boot.kernelPackages.nvidiaPackages.beta;
    };
  };

  hardware = {
    
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        nv-codec-headers-12
        vaapiVdpau
        libvdpau-va-gl
        libvdpau
        nvidia-vaapi-driver
        libva
        egl-wayland
      ];
    };
  };
}
