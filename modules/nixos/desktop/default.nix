{ pkgs, ... }:
{
  imports = [
    ./audio.nix
    ./hyprland.nix
  ];

  security.polkit.enable = true;
  programs.dconf.enable = true;
  gtk.iconCache.enable = true;
  fonts.packages = with pkgs; [
    lexend
    nerdfonts
  ];
}
