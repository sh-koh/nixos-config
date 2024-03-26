{ config
, lib
, pkgs
, inputs
, outputs
, ...
}: {

  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
  };
}
