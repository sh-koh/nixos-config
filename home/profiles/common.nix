{ pkgs, ... }:
{
  imports = [
    ../ags
    ../anyrun
    ../kitty
    ../neovim
    ../git
    ../hyprland
    ../shell
    ../theme
    ../zathura
  ];

  home = {
    username = "shakoh";
    homeDirectory = "/home/shakoh";
  };

  home.packages = with pkgs; [
    btop
    loupe
    celluloid
    pavucontrol
    wl-clipboard
    vesktop
    firefox
    grex
    gimp
    gnome.nautilus
    jq
    libreoffice
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

  # Reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.stateVersion = "23.05";
}
