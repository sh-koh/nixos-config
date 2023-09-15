{
  config
, pkgs
, lib
, theme
, inputs
, outputs
, ...
}:
{

  imports = [
    ./packages/gaming.nix
    ./packages/default.nix
    ./anyrun/default.nix
    ./kitty/default.nix
    ./neovim/default.nix
    ./git/default.nix
    ./hyprland/default.nix
    #./eww/iceberg.nix
  ];

  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    cursorTheme = {
      name = "Numix-Cursor";
      package = pkgs.numix-cursor-theme;
    };
  };

  qt = {
    enable = true;
    style.package = pkgs.libsForQt5.breeze-qt5;
    style.name = "breeze";
  };

  home.pointerCursor = {
    name = "Numix-Cursor";
    package = pkgs.numix-cursor-theme;
    x11.enable = true;
    gtk.enable = true;
    size = 16;
  };

}
