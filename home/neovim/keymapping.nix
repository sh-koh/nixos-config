{ config
, pkgs
, lib
, inputs
, outputs
, ...
}: {
  programs.nixvim.keymaps = [
    {
      action = "<cmd>CHADopen<CR>";
      key = "<C-b>";
      mode = "n";
      options = {
        silent = true;
        desc = "Toggle Tree.";
      };
    }
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
