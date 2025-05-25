{
  lib,
  pkgs,
  config,
  ...
}:
{
  environment.variables = {
    LIBVA_DRIVER_NAME = "iHD";
    VDPAU_DRIVER = "va_gl";
  };

  hardware = {
    cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableAllFirmware;
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        intel-media-driver
        intel-ocl
        intel-vaapi-driver
        libva
        libva-vdpau-driver
        libvdpau
        libvdpau-va-gl
        vaapiIntel
        vaapiVdpau
      ];
    };
  };
}
