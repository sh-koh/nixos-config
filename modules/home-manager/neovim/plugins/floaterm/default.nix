{
  programs.nixvim = {
    keymaps = [
      # {
      #   action = "<C-\\><C-n> :FloatermToggle<CR>";
      #   key = "<Esc>";
      #   mode = "n";
      #   options = {
      #     silent = true;
      #     desc = "test";
      #   };
      # }
    ];
    plugins = {
      floaterm = {
        enable = true;
        settings = {
          width = 0.7;
          height = 0.7;
          keymap_kill = "<leader>tk";
          keymap_new = "<leader>t";
          keymap_next = "<leader>tn";
          keymap_prev = "<leader>tp";
          keymap_toggle = "<leader><leader>";
          opener = "edit ";
          rootmarkers = [
            ".project"
            ".git"
            ".hg"
            ".svn"
            ".root"
          ];
        };
      };
    };
  };
}
