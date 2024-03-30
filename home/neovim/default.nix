{ config
, pkgs
, lib
, inputs
, outputs
, ...
}: {

  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./blankline.nix
    ./cmp.nix
    ./telescope.nix
    ./lsp.nix
    ./keymapping.nix
    ./treesitter.nix
  ];

  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    clipboard.providers.wl-copy.enable = true;
    clipboard.register = "unnamedplus";
    opts = {
      number = true;
      relativenumber = true;
      shiftwidth = 2;
      tabstop = 2;
      updatetime = 300;
      termguicolors = true;
      signcolumn = "yes";
      expandtab = true;
      cursorline = true;
    };

    highlight.NormalNC.fg = "#${config.lib.stylix.colors.base04}";
    
    plugins = {
      nix.enable = true;
      which-key.enable = true;
      bufferline.enable = true;
      luasnip.enable = true;
      cmp_luasnip.enable = true;
      nvim-tree.enable = true;
      neocord.enable = true;
      lualine = {
        enable = true;
        globalstatus = true;
	      iconsEnabled = true;
	      sectionSeparators = {
	        left = "";
	        right = "";
	      };
	      componentSeparators = {
            left = "|";
            right = "|";
        };
      };
    };
  };
}
