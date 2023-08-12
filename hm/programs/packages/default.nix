{
  default, pkgs, inputs, outputs, config, lib, ...
}:
{

  home.packages =
    let
      hyprsome = inputs.hyprsome.packages.${pkgs.system};
    in
    with pkgs;
    [
      blender
      btop
      celluloid
      cemu
      cinnamon.nemo
      dex
      discord-canary
      dunst
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
      wine-staging
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
