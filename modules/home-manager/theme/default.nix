{
  pkgs,
  config,
  inputs,
  ...
}:
let
  inherit (inputs) stylix;
in
{
  imports = [ stylix.homeManagerModules.stylix ];

  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    cursorTheme = {
      name = config.stylix.cursor.name;
      package = config.stylix.cursor.package;
      size = config.stylix.cursor.size;
    };
  };

  qt = {
    enable = true;
  };

  stylix = {
    enable = true;
    opacity = {
      applications = 1.0;
      desktop = 1.0;
      popups = 1.0;
      terminal = 0.99;
    };
    cursor = {
      name = "Simp1e";
      package = pkgs.simp1e-cursors;
      size = 24;
    };
    fonts = {
      serif = config.stylix.fonts.monospace;
      sansSerif = config.stylix.fonts.monospace;
      monospace = {
        package = pkgs.iosevka-bin;
        name = "Iosevka NF";
      };
      emoji = {
        name = "Noto Color Emoji";
        package = pkgs.noto-fonts-emoji;
      };
      sizes = {
        applications = 11;
        desktop = 11;
        popups = 11;
        terminal = 11;
      };
    };
    polarity = "dark";
    image = pkgs.fetchurl {
      url = "https://wallpaperaccess.com/full/4439470.jpg";
      hash = "sha256-ANrdbCrHoeUkWAnEE7MXKOYAf7YqEski6YhzaU+H8nk=";
    };

    base16Scheme = {
      base00 = "#0F1419"; # #0F1419 ----
      base01 = "#131721"; # #131721 ---
      base02 = "#272D38"; # #272D38 --
      base03 = "#3E4B59"; # #3E4B59 -
      base04 = "#BFBDB6"; # #BFBDB6 +
      base05 = "#E6E1CF"; # #E6E1CF ++
      base06 = "#E6E1CF"; # #E6E1CF +++
      base07 = "#F3F4F5"; # #F3F4F5 ++++
      base08 = "#AC4142"; # #AC4142 Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted
      base09 = "#D28445"; # #D28445 Integers, Boolean, Constants, XML Attributes, Markup Link Url
      base0A = "#F4BF75"; # #F4BF75 Classes, Markup Bold, Search Text Background
      base0B = "#90A959"; # #90A959 Strings, Inherited Class, Markup Code, Diff Inserted
      base0C = "#75B5AA"; # #75B5AA Support, Regular Expressions, Escape Characters, Markup Quotes
      base0D = "#6A9FB5"; # #6A9FB5 Functions, Methods, Attribute IDs, Headings
      base0E = "#AA759F"; # #AA759F Keywords, Storage, Selector, Markup Italic, Diff Changed
      base0F = "#AA759F"; # #AA759F Deprecated, Opening/Closing Embedded Language Tags, e.g. <?php ?>
    };
  };
}
