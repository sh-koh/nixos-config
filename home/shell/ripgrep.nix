{ pkgs, config, lib, ...}: {
  
  programs.ripgrep = {
    enable = true;
    arguments = [
      "--colors=line:style:bold"
    ];
  };
}
