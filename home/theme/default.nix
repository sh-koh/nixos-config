{ pkgs, config, lib, inputs, outputs, theme, ... }: {
  
  imports = [ inputs.stylix.homeManagerModules.stylix ];

  stylix = {
    opacity = {
      applications = 1.0;
      desktop = 1.0;
      popups = 1.0;
      terminal = 0.98;
    };
    cursor = {
      name = "phinger-cursors-light";
      package = pkgs.phinger-cursors;
      size = 32;
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
    
    base16Scheme = let 
      blacker = "#070912";
      black = "#0C0E17";
      darker = "#161821";
      dark = "#23252E";
      white = "#9ba0b5";
      whiter = "#c6c8d1";
      light = "#d2d4de";
      lighter = "#e3e4e8";
      red = "#e27878";
      yellow = "#e2a478";
      green = "#b4be82";
      cyan = "#89b8c2";
      blue = "#84a0c6";
      magenta = "#a093c7";
    in {
      base00 = blacker; # ----
      base01 = black;   # ---
      base02 = darker;  # --
      base03 = dark;    # -
      base04 = white;   # +
      base05 = whiter;  # ++
      base06 = light;   # +++
      base07 = lighter; # ++++
      base08 = red;     # Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted
      base09 = yellow;  # Integers, Boolean, Constants, XML Attributes, Markup Link Url
      base0A = yellow;  # Classes, Markup Bold, Search Text Background
      base0B = green;   # Strings, Inherited Class, Markup Code, Diff Inserted
      base0C = cyan;    # Support, Regular Expressions, Escape Characters, Markup Quotes
      base0D = blue;    # Functions, Methods, Attribute IDs, Headings
      base0E = magenta; # Keywords, Storage, Selector, Markup Italic, Diff Changed
      base0F = yellow;  # Deprecated, Opening/Closing Embedded Language Tags, e.g. <?php ?>
    }; 
  };
}
