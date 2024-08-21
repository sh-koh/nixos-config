{ lib, pkgs, config, ... }:
{
  environment.variables = {
    LIBVA_DRIVER_NAME = "iHD";
  };

  hardware = {
    cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        vaapiVdpau
        intel-media-driver
        intel-ocl
        intel-vaapi-driver
        libvdpau-va-gl
        libvdpau
        libva
      ];
    };
  };
}
