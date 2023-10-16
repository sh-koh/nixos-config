{ pkgs
, inputs
, outputs
, config
, lib
, ...
}: {
  programs.eww = {
    enable = true;
    package = pkgs.eww-wayland;
    configDir = ./cfg;
  };
}
