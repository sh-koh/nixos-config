{
  programs.nixvim = {
    keymaps = [
      {
        action = "<cmd>BufferLineCyclePrev<CR>";
        key = "<C-,>";
        mode = "n";
        options = {
          silent = true;
          desc = "Switch to previous buffer";
        };
      }
      {
        action = "<cmd>BufferLineCycleNext<CR>";
        key = "<C-.>";
        mode = "n";
        options = {
          silent = true;
          desc = "Switch to next buffer";
        };
      }
    ];
    plugins.bufferline = {
      enable = true;
    };
  };
}
