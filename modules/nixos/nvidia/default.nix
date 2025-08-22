{
  config,
  pkgs,
  ...
}:
{
  boot = {
    kernelParams = [
      "nvidia.NVreg_UsePageAttributeTable=1"
      "nvidia.NVreg_EnableGpuFirmware=1"
      "nvidia.NVreg_EnableMSI=1"
      "nvidia.NVreg_RegistryDwords=RmEnableAggressiveVblank=1"
      "nvidia.NVreg_RegistryDwords=RMIntrLockingMode=1"
      "nvidia.NVreg_EnableS0ixPowerManagement=1"
      "nvidia.NVreg_DynamicPowerManagement=0x02"
    ];
  };

  environment.variables = {
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    __GL_SHADER_DISK_CACHE = "1";
    __GL_SYNC_DISPLAY_DEVICE = { atrebois = "DP-1"; }.${config.networking.hostName};
    __GL_YIELD = "USLEEP";
    __GL_SYNC_TO_VBLANK = "1";
    __GL_GSYNC_ALLOWED = "1";
    __GL_VRR_ALLOWED = "1";
    __GL_DXVK_OPTIMIZATIONS = "1";
    __GL_ALLOW_UNOFFICIAL_PROTOCOL = "1";
    NVD_BACKEND = "direct";
    __NV_DISABLE_EXPLICIT_SYNC = "0";
    GBM_BACKEND = "nvidia-drm";
    LIBVA_DRIVER_NAME = "nvidia";
    VDPAU_DRIVER = "nvidia";
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
