{
  pkgs,
  config,
  inputs,
  inputs',
  ...
}:
{
  imports = [ inputs.ags.homeManagerModules.default ];

  programs.ags = {
    enable = true;
    package = inputs'.ags.packages.agsFull;
    systemd.enable = true;
    configDir = ./cfg;
    #configDir = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Documents/git/nixos-config/modules/home-manager/ags/cfg";
    extraPackages =
      with inputs'.ags.packages;
      [
        apps
        battery
        bluetooth
        io
        hyprland
        mpris
        network
        notifd
        powerprofiles
        tray
        wireplumber
      ]
      ++ (with pkgs; [
        hyprland
        bash
        dart-sass
        coreutils
      ]);
  };

  # Fix floating tray icon for Wine applications in AGS/Hyprland
  services.xembed-sni-proxy.enable = true;

  home.file.".cache/.ags_colors.scss" = {
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
