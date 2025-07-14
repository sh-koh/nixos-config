{
  pkgs,
  config,
  inputs,
  inputs',
  lib,
  ...
}:
{
  imports = [ inputs.ags.homeManagerModules.default ];

  programs.ags = {
    enable = true;
    package = inputs'.ags.packages.ags;
    systemd.enable = true;
    configDir = ./cfg;
    #configDir = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Documents/git/nixos-config/modules/home-manager/ags/cfg";
    astal = {
      gtk3Package = inputs'.ags.packages.astal3;
      gtk4Package = inputs'.ags.packages.astal4;
      ioPackage = inputs'.ags.packages.io;
      gjsPackage = inputs'.ags.packages.gjsPackage;
    };
    extraPackages =
      with inputs'.ags.packages;
      [
        apps
        battery
        bluetooth
        hyprland
        mpris
        network
        # niri # TODO: waiting for https://github.com/Aylur/astal/pull/70
        notifd
        powerprofiles
        tray
        wireplumber
      ]
      ++ (with pkgs; [
        # config.wayland.windowManager.hyprland.package
        config.programs.niri.package
        bash
        dart-sass
        coreutils
      ]);
  };

  services.snixembed.enable = true;
  systemd.user.services.ags.Unit.After = lib.mkForce "graphical-session.target";

  xdg.configFile."stylix/palette.scss" = {
    inherit (config.programs.ags) enable;
    onChange = ''${pkgs.systemd}/bin/systemctl --user restart ags.service'';
    text = with config.lib.stylix.colors.withHashtag; ''
      $base00: ${base00};
      $base01: ${base01};
      $base02: ${base02};
      $base03: ${base03};
      $base04: ${base04};
      $base05: ${base05};
      $base06: ${base06};
      $base07: ${base07};
      $base08: ${base08};
      $base09: ${base09};
      $base0A: ${base0A};
      $base0B: ${base0B};
      $base0C: ${base0C};
      $base0D: ${base0D};
      $base0E: ${base0E};
      $base0F: ${base0F};
    '';
  };
}
