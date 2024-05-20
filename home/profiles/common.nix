{ config
, pkgs
, lib
, inputs
, outputs
, ...
}: {
  imports = [
    ../ags
    ../anyrun
    ../kitty
    ../neovim
    ../git
    ../hyprland
    ../shell
    ../theme
  ];

  home = {
    username = "shakoh";
    homeDirectory = "/home/shakoh";
  };

  home.packages = with pkgs; [
    vesktop
    firefox
    grex
    gimp
    gnome.nautilus
    libreoffice
    molotov
    overskride
    parsec-bin
    qbittorrent
    remmina
    teams-for-linux
    thunderbird
    tldr
  ];

  services.ssh-agent.enable = true;
  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    compression = true;
    matchBlocks = {
      "atrebois" = {
        hostname = "192.168.1.201";
        host = "atrebois";
        port = 72;
        user = "shakoh";
        identityFile = "~/.ssh/id_atrebois";
      };
      "rocaille" = {
        hostname = "192.168.1.202";
        host = "rocaille";
        port = 72;
        user = "shakoh";
        identityFile = "~/.ssh/id_rocaille";
      };
      "cravite" = {
        hostname = "192.168.1.253";
        host = "cravite";
        port = 72;
        user = "shakoh";
        identityFile = "~/.ssh/id_cravite";
      };
    };
  };

  xdg = {
    enable = true;
    desktopEntries = {
      steam = {
        name = "Steam";
        icon = "steam";
        exec = "steam -pipewire-dmabuf";
      };
      tetrio-desktop = {
        name = "Tetr.io";
        icon = "tetrio-desktop";
        exec = "gamemoderun tetrio-desktop";
      };
      molotov = {
        name = "Molotov";
        icon = "molotov";
        exec = "env GDK_BACKEND=x11 molotov --no-sandbox";
      };
      osu-lazer-bin = {
        name = "osu!";
        icon = "osu!";
        exec = "gamemoderun osu\!";
      };
      vesktop = {
        name = "Vesktop";
        icon = "vesktop";
        exec = "vesktop --use-gl=angle --use-angle=gl --enable-features=VaapiIgnoreDriverChecks,VaapiVideoEncoder,VaapiVideoDecoder,CanvasOopRasterization,UseMultiPlaneFormatForHardwareVideo";
      };
    };
  };

  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    cursorTheme = {
      name = "phinger-cursors-light";
      package = pkgs.phinger-cursors;
      size = 32;
    };
  };

  qt = {
    enable = true;
  };

  # Reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.stateVersion = "23.05";
}
