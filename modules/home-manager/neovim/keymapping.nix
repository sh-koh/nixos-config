{
  programs.nixvim = {
    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };
    keymaps = [
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
      {
        action = "<cmd>bd<CR>";
        key = "<C-/>";
        mode = "n";
        options = {
          silent = true;
          desc = "Close focused buffer";
        };
      }
      {
        action = "<cmd>nohlsearch<CR>";
        key = "<Esc>";
        mode = "n";
        options = {
          silent = true;
          desc = "Clear highlight after search";
        };
      }
      {
        action = "<cmd>Neogit<CR>";
        key = "<C-;>";
        mode = "n";
        options = {
          silent = true;
          desc = "Invoke Neogit";
        };
      }
    ];
  };
}
