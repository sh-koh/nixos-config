{ config
, pkgs
, lib
, inputs
, outputs
, ...
}: {

  programs.nixvim.plugins.cmp = {
    enable = true;
    settings = {
      sources = [
        { name = "path"; }
        { name = "nvim_lsp"; }
        { name = "buffer"; }
        { name = "treesitter"; }
      ];
      mapping = {
        "<C-Space>" = "cmp.mapping.complete()";
        "<C-d>" = "cmp.mapping.scroll_docs(-4)";
        "<C-e>" = "cmp.mapping.close()";
        "<C-f>" = "cmp.mapping.scroll_docs(4)";
        "<CR>" = "cmp.mapping.confirm({ select = true })";
        "<S-M-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
        "<S-Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
      };
    };
  };
}
