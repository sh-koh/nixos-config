{
  pkgs,
  inputs,
  inputs',
  ...
}:
{
  home.sessionVariables = {
    HOSTNAME = "atrebois";
  };

  imports = with inputs.self.homeModules; [
    ags
    kitty
    neovim
    niri
    vesktop
  ];

  programs = {
    obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        obs-pipewire-audio-capture
        obs-vkcapture
      ];
    };
  };

  services = {
    gnome-keyring.enable = true;
  };

  xdg = {
    dataFile = {
      "lutris/runners/proton/GE-Proton" = {
        source = pkgs.proton-ge-bin.steamcompattool;
      };
    };
  };

  home.file = {
    ".steam/root/compatibilitytools.d/XIV-Proton" = {
      source = pkgs.proton-xiv-bin.steamcompattool;
    };
  };

  home.packages = with pkgs; [
    celluloid
    blender
    bottles
    drawio
    libreoffice
    loupe
    ghidra
    gimp3
    gnome-secrets
    helvum
    nautilus
    papers
    parsec-bin
    pwvucontrol
    qbittorrent
    remmina
    sshfs
    teams-for-linux
    telegram-desktop
    thunderbird
    wl-clipboard
    inputs'.zen-browser-flake.packages.zen-browser
  ];

  nixpkgs.config.cudaSupport = true;
}
