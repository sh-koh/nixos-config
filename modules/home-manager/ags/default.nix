{
  pkgs,
  config,
  lib,
  inputs,
  ...
}:
let
  inherit (inputs) ags;
in
{
  imports = [ ags.homeManagerModules.default ];

  programs.ags = {
    enable = true;
    configDir = ./cfg;
    #configDir = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Documents/Git/nixos-config/home/ags/cfg";
    extraPackages = with pkgs; [
      bash
      dart-sass
      coreutils
    ];
  };

  systemd.user.services.ags = {
    Unit = {
      Description = "Aylur's Gtk Shell";
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      Environment = "PATH=/run/wrappers/bin:${lib.makeBinPath config.programs.ags.extraPackages}";
      ExecStart = "${config.programs.ags.package}/bin/ags";
      Restart = "on-failure";
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };
}
