{ config
, pkgs
, lib
, inputs
, outputs
, ...
}: {

  programs.nixvim.keymaps = [
    {
      action = "<cmd>Neotree toggle<CR>";
      key = "<C-b>";
      mode = "n";
      options = {
        desc = "Toggle Neotree View.";
      };
    }
  ];
}
