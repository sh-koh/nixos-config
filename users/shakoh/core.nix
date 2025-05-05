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
    packages = with pkgs; [
      btop
      coreutils
      curl
      jq
      grex
      lm_sensors
      lshw
      pciutils
      psmisc
      tldr
      usbutils
      wget
      wikiman
    ];
  };

  programs.home-manager.enable = true;
  systemd.user.startServices = "sd-switch";
}
