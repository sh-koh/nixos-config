{ pkgs
, config
, lib
, inputs
, outputs
, theme
, ...
}: {
  
  imports = [ inputs.stylix.homeManagerModules.stylix ];

  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    cursorTheme = {
      name = "phinger-cursors-dark";
      package = pkgs.phinger-cursors;
      size = 16;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "adwaita-dark";
  };

  stylix = {
    enable = true;
    opacity = {
      applications = 1.0;
      desktop = 1.0;
      popups = 1.0;
      terminal = 0.98;
    };
    cursor = {
      name = "phinger-cursors-dark";
      package = pkgs.phinger-cursors;
      size = 16;
    };
    fonts = {
      serif = {
        package = pkgs.lexend;
        name = "Lexend";
      };
      sansSerif = config.stylix.fonts.serif;
      monospace = {
        package = pkgs.jetbrains-mono;
        name = "JetBrains Mono";
      };
      emoji = {
        name = "Noto Color Emoji";
        package = pkgs.noto-fonts-emoji;
      };
      sizes = {
        applications = 10;
        desktop = 10;
        popups = 10;
        terminal = 10;
      };
    };
    polarity = "dark";
    image = pkgs.fetchurl {
      url = "https://preview.redd.it/r1cji9zj3nva1.jpg?width=5760&format=pjpg&auto=webp&s=3545dd013e63c4c67745117d7e20a41d9ea9e7ef";
      sha256 = "1GUCUtxFqgqlr3e36OSP8bP0hihwdlUzTbfPDElUZG8=";
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
