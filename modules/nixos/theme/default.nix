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
      qt.enable = true;
    };
    base16Scheme = {
      base00 = "#151515"; # ----
      base01 = "#202020"; # ---
      base02 = "#303030"; # --
      base03 = "#505050"; # -
      base04 = "#B0B0B0"; # +
      base05 = "#D0D0D0"; # ++
      base06 = "#E0E0E0"; # +++
      base07 = "#F5F5F5"; # ++++
      base08 = "#F07178"; # Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted
      base09 = "#F78C6C"; # Integers, Boolean, Constants, XML Attributes, Markup Link Url
      base0A = "#FFCB6B"; # Classes, Markup Bold, Search Text Background
      base0B = "#C3E88D"; # Strings, Inherited Class, Markup Code, Diff Inserted
      base0C = "#89DDFF"; # Support, Regular Expressions, Escape Characters, Markup Quotes
      base0D = "#82AAFF"; # Functions, Methods, Attribute IDs, Headings
      base0E = "#C792EA"; # Keywords, Storage, Selector, Markup Italic, Diff Changed
      base0F = "#FF5370"; # Deprecated, Opening/Closing Embedded Language Tags, e.g. <?php ?>
    };
  };
}
