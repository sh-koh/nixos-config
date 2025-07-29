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
        cd = "__zoxide_z";
        fd = "${getExe fd} -H";
        cat = "${getExe bat} --style=changes,numbers --color=auto --paging=never --italic-text=always --tabs=2 --wrap=never --binary=as-text";
        less = "${getExe bat} --style=changes,numbers --color=auto --paging=always --italic-text=always --tabs=2 --wrap=never --binary=no-printing";
        rg = "${getExe ripgrep} -SpnH";
        untar = "tar --zstd -xpvf";
        mktar = "tar --zstd -cvf";
      };
  };
}
