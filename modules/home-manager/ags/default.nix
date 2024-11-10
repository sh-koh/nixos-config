{
  pkgs,
  config,
  lib,
  inputs,
  inputs',
  ...
}:
{
  imports = [ inputs.ags.homeManagerModules.default ];

  programs.ags = {
    enable = true;
    configDir = ./cfg;
    #configDir = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Documents/git/nixos-config/modules/home-manager/ags/cfg";
    extraPackages = with pkgs; [
      inputs'.ags.packages.battery
      inputs'.ags.packages.bluetooth
      inputs'.ags.packages.io
      inputs'.ags.packages.hyprland
      inputs'.ags.packages.network
      inputs'.ags.packages.notifd
      inputs'.ags.packages.powerprofiles
      inputs'.ags.packages.wireplumber
      bash
      dart-sass
      coreutils
    ];
  };

  systemd.user.services.ags = {
    Unit = {
      Description = "Aylur's Gtk Shell V2";
      PartOf = [
        "hyprland-session.target"
        "graphical-session.target"
      ];
    };
    Service = {
      Environment = "PATH=/run/wrappers/bin:${lib.makeBinPath config.programs.ags.extraPackages}";
      ExecStart = "${config.programs.ags.package}/bin/ags";
      Restart = "on-failure";
    };
    Install.WantedBy = [
      "hyprland-session.target"
      "graphical-session.target"
    ];
  };
}
