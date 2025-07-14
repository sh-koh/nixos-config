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
      file
      grex
      jq
      kubectl
      lm_sensors
      lshw
      pciutils
      psmisc
      tldr
      usbutils
      wget
      wikiman
      xxd
    ];
  };

  programs.home-manager.enable = true;
  systemd.user.startServices = "sd-switch";
}
