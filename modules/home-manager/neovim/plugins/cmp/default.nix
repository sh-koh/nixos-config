{
  programs.nixvim.plugins = {
    cmp = {
      enable = true;
      settings = {
        snippet.expand = "function(args) require('luasnip').lsp_expand(args.body) end";
        mapping = {
          "<C-Space>" = "cmp.mapping.complete()";
          "<C-e>" = "cmp.mapping.close()";
          "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
          "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
          "<CR>" = "cmp.mapping.confirm({ select = true })";
        };
        sources = [
          { name = "path"; }
          { name = "nvim_lsp"; }
          { name = "buffer"; option.get_bufnrs.__raw = "vim.api.nvim_list_bufs"; }
          { name = "neorg"; }
        ];
      };
    };
  };
}
