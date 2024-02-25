{ config
, pkgs
, lib
, inputs
, outputs
, ...
}: {

  programs.nixvim.plugins.nvim-cmp = {
    enable = true;
    autoEnableSources = true;
    sources = [
      { name = "path"; }
      { name = "nvim_lsp"; }
      { name = "buffer"; }
      { name = "treesitter"; }
    ];
    mapping = {
      "<CR>" = "cmp.mapping.confirm({ select = true })";
      "<M-Tab>" = {
        action = ''
          function(fallback)
	        local luasnip = require('luasnip')
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expandable() then
              luasnip.expand()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif check_backspace() then
              fallback()
            else
              fallback()
            end
          end
        '';
        modes = [ "i" "s" ];
      };
    };
  };
}
