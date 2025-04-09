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

  home.packages = with pkgs; [
    celluloid
    drawio
    libreoffice
    loupe
    #gimp
    gnome-secrets
    nautilus
    papers
    parsec-bin
    pwvucontrol
    remmina
    teams-for-linux
    telegram-desktop
    thunderbird
    vesktop
    wl-clipboard
    inputs'.zen-browser-flake.packages.zen-browser

    file
    ghidra
    xxd
  ];

  nixpkgs.config.cudaSupport = true;
}
