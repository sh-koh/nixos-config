{ inputs, ... }:
{
  imports = [ inputs.raspberry-pi.nixosModules.raspberry-pi ];

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
        };
        dt-overlays = {
          # Make GPU works.
          vc4-kms-v3d-pi5 = {
            enable = true;
            params = { };
          };
        };
      };
    };
  };

  nixpkgs.hostPlatform = "aarch64-linux";
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "23.11";
}
