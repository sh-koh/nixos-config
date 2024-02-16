{ config
, pkgs
, lib
, inputs
, outputs
, ...
}: {
  imports = [
    ./common.nix
  ];

  home.packages = with pkgs; [
  ];
}
