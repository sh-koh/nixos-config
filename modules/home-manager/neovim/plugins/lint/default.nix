{ pkgs, ... }:
{
  programs.nixvim = {
    plugins = {
      lint = {
        enable = true;
      };
    };
    extraPackages = with pkgs; [
      vale
      tflint
    ];
  };
}
