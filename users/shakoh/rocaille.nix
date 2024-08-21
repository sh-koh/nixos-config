{ pkgs, inputs, ... }:
{
  imports = with inputs.self.homeManagerModules; [
    ags
    anyrun
    hyprland
    kitty
    zathura
  ];

  home.packages = with pkgs; [ ];
}
