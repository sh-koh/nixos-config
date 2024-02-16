{ pkgs, config, lib, inputs, outputs, theme, ... }: {
  
  imports = [ inputs.stylix.homeManagerModules.stylix ];

  stylix = {
    opacity = {
      applications = 1.0;
      desktop = 1.0;
      popups = 1.0;
      terminal = 0.96;
    };
    cursor = {
      name = "phinger-cursors-light";
      package = pkgs.phinger-cursors;
      size = 32;
    };
    fonts = {
      serif = config.stylix.fonts.monospace;
      sansSerif = config.stylix.fonts.monospace;
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
      blacker = "#161821";
      black = "#292d3d";
      darker = "#484b5b";
      dark = "#6b7089";
      red = "#e27878";
      red1 = "#e98989";
      green = "#b4be82";
      green1 = "#c0ca8e";
      yellow = "#e2a478";
      yellow1 = "#e9b189";
      blue = "#84a0c6";
      blue1 = "#91acd1";
      magenta = "#a093c7";
      magenta1 = "#ada0d3";
      cyan = "#89b8c2";
      cyan1 = "#95c4ce";
      white = "#9ba0b5";
      whiter = "#c6c8d1";
      light = "#d2d4de";
      lighter = "#e3e4e8";
    in
    {
      base00 = blacker; # Noir le plus noir
      base01 = black; # ---
      base02 = darker; # --
      base03 = dark; # -
      base04 = white;# +
      base05 = whiter; # ++
      base06 = light; # +++
      base07 = lighter; # Blanc le plus blanc
      base08 = red; # Rouge
      base09 = yellow1; # Orange
      base0A = yellow; # Jaune
      base0B = green; # Vert
      base0C = cyan; # Cyan
      base0D = blue; # Bleu
      base0E = magenta; # Violet
      base0F = magenta1; # Rose
    }; 
  };
}
