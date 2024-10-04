{
  programs.nixvim.plugins.telescope = {
    enable = true;
    extensions = {
      ui-select.enable = true;
      fzf-native.enable = true;
      file-browser = {
        enable = true;
        settings = {
          hidden = true;
          autoDepth = true;
          depth = 999;
        };
      };
    };
    keymaps = {
      "<leader>fb" = "buffers";
      "<leader>ff" = "find_files";
      "<leader>fh" = "search_history";
      "<leader>fg" = "live_grep";
    };
    settings = {
      defaults = {
        sorting_strategy = "descending";
        layout_config = {
          preview_cutoff = 120;
          horizontal = {
            padding = [ 0 0 ];
            width = 0.99;
            height = 0.99;
            prompt_position = "bottom";
            preview_width = 0.60;
          };
          vertical = {
            width = 0.99;
            height = 0.99;
            mirror = false;
          };
        };
      };
    };
  };
}
