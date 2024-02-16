{ pkgs, config, lib, ... }: {

  imports = [ ];

  programs.tmux = {
    enable = true;
    aggressiveResize = true;
    clock24 = true;
    keyMode = "vi";
    mouse = true;
    plugins = with pkgs.tmuxPlugins; [{ plugin = vim-tmux-navigator; }];
  };
}
