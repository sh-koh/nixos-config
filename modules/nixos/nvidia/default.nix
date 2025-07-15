{
  config,
  pkgs,
  ...
}:
{
  boot = {
    extraModprobeConfig = ''
      options nvidia NVreg_UsePageAttributeTable=1
      options nvidia NVreg_InitializeSystemMemoryAllocations=1
      options nvidia NVreg_EnableGpuFirmware=1
      options nvidia NVreg_EnablePCIeGen3=1
      options nvidia NVreg_EnableMSI=1
      options nvidia NVreg_RegistryDwords="PerfLevelSrc=0x2222"
    '';
  };

  environment.variables = {
    GBM_BACKEND = "nvidia-drm";
    LIBVA_DRIVER_NAME = "nvidia";
    VDPAU_DRIVER = "nvidia";
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
    __NV_DISABLE_EXPLICIT_SYNC = "0";
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware = {
    nvidia-container-toolkit = {
      enable = config.virtualisation.podman.enable || config.virtualisation.docker.enable;
      suppressNvidiaDriverAssertion = true;
    };
    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.beta;
      open = true;
      modesetting.enable = true;
      nvidiaSettings = false;
      powerManagement.enable = true;
    };
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        egl-wayland
        libva
        libva-vdpau-driver
        libvdpau
        libvdpau-va-gl
        nv-codec-headers-12
        vaapiVdpau
      ];
    };
  };

  nixpkgs.config.cudaSupport = true;
}
