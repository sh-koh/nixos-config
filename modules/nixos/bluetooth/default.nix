{
  lib,
  config,
  pkgs,
  ...
}:
{
  hardware.bluetooth = {
    enable = true;
  };

  environment.systemPackages = lib.mkIf (
    config.programs.hyprland.enable || config.programs.niri.enable
  ) [ pkgs.overskride ];
}
