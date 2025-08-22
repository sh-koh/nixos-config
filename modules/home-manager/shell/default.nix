{
  config,
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
        find = "${getExe config.programs.fd.package}";
        grep = "${getExe config.programs.ripgrep.package}";
        cat = "${getExe config.programs.bat.package} --style=changes,numbers --color=auto --paging=never --italic-text=always --tabs=2 --wrap=never --binary=as-text";
        less = "${getExe config.programs.bat.package} --style=changes,numbers --color=auto --paging=always --italic-text=always --tabs=2 --wrap=never --binary=no-printing";
        untar = "tar --zstd -xpvf";
        mktar = "tar --zstd -cvf";
      };
  };
}
