{
  programs.nixvim = {
    keymaps = [
      {
        action = "<cmd>Markview<CR>";
        key = "<leader>m";
        mode = "n";
        options = {
          silent = true;
          desc = "Toggle Markview";
        };
      }
    ];
    plugins = {
      markview = {
        enable = true;
        settings = {
          headings = {
            shift_width = 0;
          };
        };
      };
    };
  };
}
