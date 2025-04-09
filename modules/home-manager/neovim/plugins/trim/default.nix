{ config, ... }:
{
  programs.nixvim.plugins = {
    trim = {
      enable = true;
      settings = {
        highlight = false;
        highlight_bg = config.lib.stylix.colors.withHashtag.base08;
        ft_blocklist = [
          "calendar"
          "checkhealth"
          "dashboard"
          "floaterm"
          "help"
          "lspinfo"
          "oil"
          "TelescopePrompt"
        ];
      };
    };
  };
}
