{ pkgs, ... }:
{
  home.sessionVariables = {
    HOSTNAME = "cravite";
  };

  home.packages = with pkgs; [ ];
}
