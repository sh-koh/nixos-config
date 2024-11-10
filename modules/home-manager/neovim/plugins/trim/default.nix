{
  programs.nixvim.plugins = {
    trim = {
      enable = true;
      settings = {
        highlight = true;
        ft_blocklist = [
          "checkhealth"
          "dashboard"
          "floaterm"
          "lspinfo"
          "calendar"
          "oil"
          "TelescopePrompt"
        ];
      };
    };
  };
}
