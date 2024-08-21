{ lib, pkgs, config, ... }:
{
  imports = [ ];

  programs.home-manager.enable = true;
  home = {
    username = "shakoh";
    homeDirectory = "/home/${config.home.username}";
    stateVersion = lib.mkDefault "23.05";
    packages = with pkgs; [ file ];
  };

  systemd.user.startServices = "sd-switch";
  nixpkgs.config.allowUnfree = true;
}
