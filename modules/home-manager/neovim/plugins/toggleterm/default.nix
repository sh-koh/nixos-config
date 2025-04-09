{
  programs.nixvim = {
    keymaps = [
      {
        mode = "t";
        key = "<C-Space>";
        action = "<cmd>ToggleTerm<CR>";
        options = {
          silent = true;
          desc = "Exit ToggleTerm";
        };
      }
    ];
    plugins.toggleterm = {
      enable = true;
      settings = {
        open_mapping = "[[<C-Space>]]";
        auto_scroll = true;
        autochdir = false;
        close_on_exit = false;
        direction = "float";
        float_opts = {
          border = "rounded";
          # col = null;
          height = 40;
          # row = null;
          # title_pos = null;
          width = 145;
          # winblend = null;
          # zindex = null;
        };
        hide_numbers = true;
        # on_close.__raw = '''';
        # on_create.__raw = '''';
        # on_exit.__raw = ''''
        # on_open.__raw = '''';
        # on_stderr.__raw = '''';
        # on_stdout.__raw = '''';
        persist_mode = true;
        persist_size = true;
        size = 15;
        start_in_insert = true;
      };
    };
  };
}
