{ pkgs, ... }:
{
  programs = {
    hyprland = {
      enable = true;
      withUWSM = true;
    };
    hyprlock = {
      enable = true;
    };
  };

  services = {
    hypridle.enable = true;
  };

  xdg = {
    portal = {
      extraPortals = with pkgs; [
        xdg-desktop-portal-hyprland
        xdg-desktop-portal-gtk
      ];
      config.common = {
        default = [
          "hyprland"
          "gtk"
        ];
        "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
      };
    };
  };
}
