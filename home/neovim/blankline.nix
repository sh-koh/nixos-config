{ pkgs, lib, config, ... }: {

  programs.nixvim.plugins.indent-blankline = {
    enable = true;

  };
}
