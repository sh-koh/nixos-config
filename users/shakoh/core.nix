{ lib, pkgs, config, ... }:
{
  imports = [ ];

  home = {
    username = "shakoh";
    homeDirectory = "/home/${config.home.username}";
    stateVersion = lib.mkDefault "23.05";
    packages = with pkgs; [
      file
      xxd
    ];
  };

  programs.home-manager.enable = true;
  systemd.user.startServices = "sd-switch";
  nixpkgs.config.allowUnfree = true;
}
