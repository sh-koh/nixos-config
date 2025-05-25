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

  imports = with inputs.self.homeManagerModules; [
    ags
    anyrun
    hyprland
    kitty
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

  home.packages = with pkgs; [
    celluloid
    drawio
    libreoffice
    loupe
    gimp3
    gnome-secrets
    helvum
    nautilus
    papers
    parsec-bin
    pwvucontrol
    remmina
    teams-for-linux
    telegram-desktop
    thunderbird
    wl-clipboard
    inputs'.zen-browser-flake.packages.zen-browser

    file
    ghidra
    xxd
  ];

  nixpkgs.config.cudaSupport = true;
}
