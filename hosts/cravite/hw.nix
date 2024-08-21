{ lib, ... }:
{
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/5727bbfc-f35c-43b8-a461-d0c921b1834e";
      fsType = "btrfs";
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/022E-76E8";
      fsType = "vfat";
    };
  };

  nixpkgs.hostPlatform = "aarch64-linux";
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "23.11";
}
