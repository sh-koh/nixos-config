{ inputs, lib, ... }:
{
  imports = with inputs.raspberry-pi.nixosModules; [
    raspberry-pi
    sd-image
  ];

  boot.initrd.systemd = {
    enable = lib.mkForce false;
    network.enable = lib.mkForce false;
    tpm2.enable = false;
  };

  raspberry-pi-nix = {
    board = "bcm2712";
    libcamera-overlay.enable = false;
  };

  hardware.raspberry-pi = {
    config = {
      all = {
        options = {
          # Leave RP1 PCIe configured on hand-off.
          pciex4_reset = {
            enable = true;
            value = true;
          };

          # 64 bit
          arm_64bit = {
            enable = true;
            value = true;
          };

          # Increases arm_freq to the highest supported frequency for the board-type and firmware. Set to 1 to enable.
          arm_boost = {
            enable = true;
            value = true;
          };

          display_auto_detect = {
            enable = true;
            value = true;
          };

          disable_overscan = {
            enable = true;
            value = true;
          };
        };
        dt-overlays = {
          # Make GPU works.
          vc4-kms-v3d-pi5 = {
            enable = true;
            params = { };
          };
        };
        base-dt-params = {
          krnbt = {
            enable = true;
            value = "on";
          };
          i2c_arm = {
            enable = true;
            value = "on";
          };
          i2s = {
            enable = true;
            value = "on";
          };
          spi = {
            enable = true;
            value = "on";
          };
        };
      };
    };
  };

  system.stateVersion = "23.11";
}
