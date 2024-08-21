{ pkgs, ... }:
{
  programs.hyprland.enable = true;
  environment.variables = {
    NIXOS_OZONE_WL = "1";
    LIBSEAT_BACKEND = "logind";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    QT_QPA_PLATFORM = "wayland;xcb";
    #SDL_VIDEODRIVER = "wayland,x11";
    CLUTTER_BACKEND = "wayland";
    MOZ_ENABLE_WAYLAND = "1";
    MOZ_WEBRENDER = "1";
    GDK_BACKEND = "wayland,x11";
  };

  environment.systemPackages = with pkgs; [
    btop
    loupe
    celluloid
    pavucontrol
    wl-clipboard
    nautilus
    tldr
  ];
}
