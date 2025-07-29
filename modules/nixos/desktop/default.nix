{ pkgs, config, ... }:
{
  fonts.packages = with pkgs; [
    lexend
    # nerd-fonts.ubuntu-mono
    # nerd-fonts.droid-sans-mono
    # nerd-fonts.hack
    # intel-one-mono
    # julia-mono
    # nerd-fonts.lilex
    # nerd-fonts.noto
    # nerd-fonts.roboto-mono
  ];
  gtk.iconCache.enable = true;
  programs.regreet = {
    enable = true;
    cageArgs = [
      "-s"
      "-d"
      "-m"
      "last"
    ];
  };

  programs.goldwarden = {
    enable = true;
    useSshAgent = false;
  };

  services = {
    greetd.enable = true;
    gnome.gnome-keyring.enable = true;
  };

  security = {
    polkit.enable = true;
    rtkit.enable = true;
    pam.services = {
      greetd.enableGnomeKeyring = true;
    };
  };

  xdg = {
    portal = {
      enable = true;
      xdgOpenUsePortal = true;
      config.common = {
        "org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
      };
    };
  };

  environment.variables = {
    NIXOS_OZONE_WL = "1";
    XDG_SESSION_TYPE = "wayland";
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    CLUTTER_BACKEND = "wayland";
    GDK_BACKEND = "wayland";
  };

  services.pipewire = {
    enable = true;
    audio.enable = true;
    jack.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  warnings =
    if config.programs.hyprland.enable && config.programs.niri.enable then
      [
        ''
          Be careful, it seems you have both hyprland and niri enabled at the
          same time, xdg-desktop-portals might conflict each other.
        ''
      ]
    else
      [ ];
}
