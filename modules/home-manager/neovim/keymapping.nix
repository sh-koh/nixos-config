{
  programs.nixvim.keymaps = [
    {
      action = "<cmd>bnext<CR>";
      key = "<C-.>";
      mode = "n";
      options = {
        silent = true;
        desc = "Switch to next buffer.";
      };
    }
    {
      action = "<cmd>bprev<CR>";
      key = "<C-,>";
      mode = "n";
      options = {
        silent = true;
        desc = "Switch to previous buffer.";
      };
    }
  ];
}
