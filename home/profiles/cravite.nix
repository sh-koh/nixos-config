{ pkgs, ... }:
{
  imports = [
    ../neovim
    ../shell
    ../theme
  ];
  home.packages = with pkgs; [ ];

  home = {
    username = "shakoh";
    homeDirectory = "/home/shakoh";
  };

  systemd.user.startServices = "sd-switch";
  programs.home-manager.enable = true;
  home.stateVersion = "23.11";
}
