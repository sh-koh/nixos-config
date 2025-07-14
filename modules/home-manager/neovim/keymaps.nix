{
  programs.nixvim = {
    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };
    keymaps = [
      {
        mode = "i";
        key = "<Tab>";
        action = ''pumvisible() ? "\<C-n>" : "\<Tab>"'';
        options = {
          silent = true;
          expr = true;
          desc = "Select next completion with <Tab>";
        };
      }
      {
        mode = "i";
        key = "<S-Tab>";
        action = ''pumvisible() ? "\<C-p>" : "\<S-Tab>"'';
        options = {
          silent = true;
          expr = true;
          desc = "Select previous completion with <S-Tab>";
        };
      }
      {
        mode = "n";
        key = "<C-.>";
        action = "<cmd>bnext<CR>";
        options = {
          silent = true;
          desc = "Switch to next buffer";
        };
      }
      {
        mode = "n";
        key = "<C-,>";
        action = "<cmd>bprev<CR>";
        options = {
          silent = true;
          desc = "Switch to previous buffer";
        };
      }
      {
        mode = "n";
        key = "<C-/>";
        action = "<cmd>bdelete<CR>";
        options = {
          silent = false;
          desc = "Close focused buffer";
        };
      }
      {
        mode = "n";
        key = "g.";
        action = "<cmd>tabnext<CR>";
        options = {
          silent = true;
          desc = "Switch to next tab";
        };
      }
      {
        mode = "n";
        key = "g,";
        action = "<cmd>tabprev<CR>";
        options = {
          silent = true;
          desc = "Switch to previous tab";
        };
      }
      {
        mode = "n";
        key = "g/";
        action = "<cmd>tabnew<CR>";
        options = {
          silent = false;
          desc = "Open a new tab";
        };
      }
      {
        mode = "n";
        key = "g?";
        action = "<cmd>tabclose<CR>";
        options = {
          silent = false;
          desc = "Close focused tab";
        };
      }
      {
        mode = "n";
        key = "<esc>";
        action = "<cmd>nohlsearch<CR>";
        options = {
          silent = true;
          desc = "Clear highlight after search";
        };
      }
      {
        mode = "t";
        key = "<esc>";
        action = "<C-\\><C-n>";
        options = {
          silent = true;
          desc = "Normal mode from terminal mode";
        };
      }
    ];
  };
}
