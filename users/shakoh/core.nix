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
      dua
      file
      grex
      jaq
      kubectl
      lm_sensors
      lshw
      oha
      pciutils
      presenterm
      psmisc
      sshfs
      strace
      tealdeer
      usbutils
      wget
      xxd
    ];
  };

  programs.home-manager.enable = true;
  systemd.user.startServices = "sd-switch";
}
