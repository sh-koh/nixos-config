{ pkgs, inputs, ... }:
{
  imports = with inputs.self.homeManagerModules; [
    ags
    anyrun
    hyprland
    kitty
    zathura
  ];

  programs = {
    obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        obs-nvfbc
        obs-pipewire-audio-capture
        obs-vaapi
        obs-vkcapture
        obs-websocket
      ];
    };
  };

  home.packages = with pkgs; [
    libreoffice
    gimp
    vesktop
    firefox
    parsec-bin
    qbittorrent
    remmina
    teams-for-linux
    thunderbird
  ];
}