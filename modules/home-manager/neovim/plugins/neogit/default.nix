{
  programs.nixvim = {
    keymaps = [
      {
        action = "<cmd>Neogit<CR>";
        key = "<leader>p";
        mode = "n";
        options = {
          silent = true;
          desc = "Open Neogit";
        };
      }
    ];
    plugins = {
      neogit = {
        enable = true;
      };
    };
  };
}
