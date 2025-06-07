{
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports = inputs.self.lib.listAllFiles ./.;

  home = {
    shellAliases =
      with lib;
      with pkgs;
      {
        ".." = "cd ..";
        "..." = "cd ../..";
        "...." = "cd ../../..";
        "....." = "cd ../../../..";
        cat = "${getExe bat} --style=auto --color=auto --paging=never --tabs=2 --wrap=never";
        cd = "__zoxide_z";
        fd = "${getExe fd} -H";
        less = "${getExe bat} --style=auto --color=auto --paging=always --number --tabs=2 --wrap=never";
        rg = "${getExe ripgrep} -SpnH";
        untar = "tar xpvf";
        mktar = "tar czvf";
      };
  };
}
