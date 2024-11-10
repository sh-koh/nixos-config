{
  programs.nixvim.plugins = {
    indent-blankline = {
      enable = true;
      settings = {
        scope = {
          enabled = true;
          show_start = true;
        };
        exclude = {
          buftypes = [ "terminal" "nofile" ];
          filetypes = [
            "help"
            "dashboard"
            "oil"
            "calendar"
          ];
        };
      };
    };
  };
}
