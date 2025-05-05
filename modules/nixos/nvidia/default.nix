{
  config,
  pkgs,
  ...
}:
{
  boot = {
    kernelParams = [
      "nvidia-drm.fbdev=1"
    ];
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
    # TODO: driver 575.51.02
    #__NV_DISABLE_EXPLICIT_SYNC = "0";
    #NVPRESENT_ENABLE_SMOOTH_MOTION = "1";
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware = {
    nvidia-container-toolkit.enable =
      config.virtualisation.podman.enable || config.virtualisation.docker.enable;
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

  nixpkgs.config.cudaSupport = true;
}
