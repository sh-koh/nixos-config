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
    kitty
    neovim
    niri
    vesktop
  ];

  services = {
    gnome-keyring.enable = true;
  };

  home.packages = with pkgs; [
    celluloid
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
}
