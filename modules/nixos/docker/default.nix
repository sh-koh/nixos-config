{ config, pkgs, ... }:
{
  virtualisation = {
    docker = {
      enable = true;
      enableOnBoot = false;
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
      backend = "docker";
    };
  };
  environment.systemPackages = [ pkgs.docker-compose ];
}
