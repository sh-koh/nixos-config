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
      coreutils-full
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
      typst
      usbutils
      watchexec
      wget
      wl-clipboard-rs
      xxd
    ];
  };

  programs.home-manager.enable = true;
  systemd.user.startServices = "sd-switch";
}
