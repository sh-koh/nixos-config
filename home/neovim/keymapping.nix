{ config
, pkgs
, lib
, inputs
, outputs
, ...
}: {

  programs.nixvim.keymaps = [
    {
      action = "<cmd>NvimTreeToggle<CR>";
      key = "<C-b>";
      mode = "n";
      options = {
        silent = true;
        desc = "Toggle Tree.";
      };
    }
  ];
}
