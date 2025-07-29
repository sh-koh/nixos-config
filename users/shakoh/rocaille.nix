{
  pkgs,
  inputs,
  inputs',
  ...
}:
{
  home.sessionVariables = {
    HOSTNAME = "rocaille";
  };

  imports = with inputs.self.homeModules; [
    ags
    terminal
    neovim
    niri
    vesktop
  ];

  home.packages = with pkgs; [
    celluloid
    bottles
    drawio
    euphonica
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
    teams-for-linux
    telegram-desktop
    thunderbird
    inputs'.zen-browser-flake.packages.zen-browser
  ];
}
