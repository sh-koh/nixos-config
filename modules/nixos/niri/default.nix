{ inputs', pkgs, ... }:
{
  programs.niri = {
    enable = true;
    package = inputs'.niri.packages.niri-unstable;
  };

  security.soteria.enable = true;

  xdg = {
    portal = {
      extraPortals = with pkgs; [ xdg-desktop-portal-gnome ];
      config.common = {
        default = [ "gnome" ];
        "org.freedesktop.impl.portal.FileChooser" = [ "gnome" ];
      };
    };
  };
}
