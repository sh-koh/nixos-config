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

  imports = with inputs.self.homeManagerModules; [
    ags
    anyrun
    hyprland
    kitty
    vesktop
  ];

  services = {
    gnome-keyring.enable = true;
  };

  home.packages = with pkgs; [
    celluloid
    drawio
    libreoffice
    loupe
    gimp3
    gnome-secrets
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
}
