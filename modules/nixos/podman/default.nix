{ config, pkgs, ... }:
{
  virtualisation = {
    podman = {
      enable = true;
      autoPrune = {
        enable = true;
        dates = "weekly";
        flags = [
          "--all"
          "--force"
        ];
      };
    };
    oci-containers = {
      backend = "podman";
    };
  };
  environment.systemPackages = [ pkgs.podman-compose ];
}
