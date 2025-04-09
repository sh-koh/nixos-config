{
  pkgs,
  config,
  inputs,
  self',
  ...
}:
{
  imports = [ inputs.stylix.nixosModules.stylix ];

  environment.variables = {
    QT_STYLE_OVERRIDE = "qt6ct-style";
  };

  stylix = {
    enable = true;
    opacity = {
      applications = 0.98;
      desktop = 0.98;
      popups = 0.96;
      terminal = 0.96;
    };
    cursor = {
      name = "BreezeX-Black";
      package = self'.packages.breezex-cursor;
      size = 32;
    };
    fonts = {
      sansSerif = config.stylix.fonts.serif;
      serif = {
        package = pkgs.nerd-fonts.fira-mono;
        name = "FiraMono Nerd Font";
      };
      monospace = {
        package = pkgs.nerd-fonts.fira-code;
        name = "FiraCode Nerd Font Mono";
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
      url = "https://cdnb.artstation.com/p/assets/images/images/041/173/737/large/coppertine-numa-bg.jpg?1630968865";
      hash = "sha256-lc+8tDhxjHXJEPhB7T3vb2rC0RiXwbPKYRsTA5FdcfM=";
    };
    targets = {
      kmscon.enable = false;
      console.enable = false;
      grub.enable = false;
      gnome-text-editor.enable = false;
      nixos-icons.enable = false;
    };
    base16Scheme = {
      base00 = "#151515"; # #0F1419 ----
      base01 = "#202020"; # #131721 ---
      base02 = "#303030"; # #272D38 --
      base03 = "#505050"; # #3E4B59 -
      base04 = "#B0B0B0"; # #BFBDB6 +
      base05 = "#D0D0D0"; # #E6E1CF ++
      base06 = "#E0E0E0"; # #E6E1CF +++
      base07 = "#F5F5F5"; # #F3F4F5 ++++
      base08 = "#F07178"; # #AC4142 Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted
      base09 = "#F78C6C"; # #D28445 Integers, Boolean, Constants, XML Attributes, Markup Link Url
      base0A = "#FFCB6B"; # #F4BF75 Classes, Markup Bold, Search Text Background
      base0B = "#C3E88D"; # #90A959 Strings, Inherited Class, Markup Code, Diff Inserted
      base0C = "#89DDFF"; # #75B5AA Support, Regular Expressions, Escape Characters, Markup Quotes
      base0D = "#82AAFF"; # #6A9FB5 Functions, Methods, Attribute IDs, Headings
      base0E = "#C792EA"; # #AA759F Keywords, Storage, Selector, Markup Italic, Diff Changed
      base0F = "#FF5370"; # #AA759F Deprecated, Opening/Closing Embedded Language Tags, e.g. <?php ?>
    };
  };
}
