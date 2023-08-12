{
  default, pkgs, inputs, outputs, config, lib, ...
}:
{

  programs.eww = {
    enable = true;
    package = inputs.eww.packages.${pkgs.system}.eww-wayland;
    configDir = ./cfg;
  };
}