{
  lib,
  pkgs,
  config,
  ...
}:
{
  home = {
    username = "shakoh";
    homeDirectory = "/home/${config.home.username}";
    stateVersion = lib.mkDefault "23.05";
    packages = with pkgs; [ ];
  };

  programs.home-manager.enable = true;
  systemd.user.startServices = "sd-switch";
}
