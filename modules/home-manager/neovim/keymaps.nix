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
          desc = "Switch to next buffer";
        };
      }
      {
        action = "<cmd>bprev<CR>";
        key = "<C-,>";
        mode = "n";
        options = {
          silent = true;
          desc = "Switch to previous buffer";
        };
      }
      {
        action = "<cmd>bdelete<CR>";
        key = "<C-/>";
        mode = "n";
        options = {
          silent = false;
          desc = "Close focused buffer";
        };
      }
      {
        action = "<cmd>tabnext<CR>";
        key = "g.";
        mode = "n";
        options = {
          silent = true;
          desc = "Switch to next tab";
        };
      }
      {
        action = "<cmd>tabprev<CR>";
        key = "g,";
        mode = "n";
        options = {
          silent = true;
          desc = "Switch to previous tab";
        };
      }
      {
        action = "<cmd>tabnew<CR>";
        key = "g/";
        mode = "n";
        options = {
          silent = false;
          desc = "Open a new tab";
        };
      }
      {
        action = "<cmd>tabclose<CR>";
        key = "g?";
        mode = "n";
        options = {
          silent = false;
          desc = "Close focused tab";
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
        key = "<leader>p";
        mode = "n";
        options = {
          silent = true;
          desc = "Open Neogit";
        };
      }
      {
        action = "<cmd>Oil<CR>";
        key = "<leader>b";
        mode = "n";
        options = {
          silent = true;
          desc = "Invoke Oil";
        };
      }
    ];
  };
}
