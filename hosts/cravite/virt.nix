{ config
, lib
, pkgs
, inputs
, outputs
, ...
}: {

  virtualisation.podman = {
    enable = true;
  };
}
