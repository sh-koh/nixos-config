{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    aggressiveResize = true;
    clock24 = true;
    keyMode = "vi";
    mouse = true;
    #plugins = with pkgs.tmuxPlugins; [ { plugin = vim-tmux-navigator; } ];
    disableConfirmationPrompt = true;
    shortcut = "s";
    focusEvents = true;
  };
}
