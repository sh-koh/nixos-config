{
  default, pkgs, inputs, outputs, config, lib, ...
}:
{

  home.packages =
    let
      hyprsome = inputs.hyprsome.packages.${pkgs.system};
      ags = inputs.ags.packages.${pkgs.system};
    in
    with pkgs;
    [
      ags.default
      blender
      btop
      celluloid
      cinnamon.nemo
      dex
      discord-canary
      firefox-wayland
      gimp
      godot_4
      grc
      imv
      lf
      libreoffice
      molotov
      nixpkgs-fmt
      obs-studio
      obsidian
      parsec-bin
      qbittorrent
      swww
      thunderbird-wayland
      webcord
      wineWow64Packages.waylandFull
      hyprsome.default

      (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment =
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    ];

}
