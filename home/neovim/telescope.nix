{ config
, pkgs
, lib
, inputs
, outputs
, ...
}: {

  programs.nixvim.plugins.telescope = {
    enable = true;
    extensions = {
      ui-select.enable = true;
      fzf-native.enable = true;
      file_browser = {
        enable = true;
        hidden = true;
        depth = 9999999999;
        autoDepth = true;
      };
    };
    keymaps = {
      "<leader>ff" = "find_files";
      "<leader>fs" = "grep_string";
      "<leader>fg" = "live_grep";
    };
  };
}
