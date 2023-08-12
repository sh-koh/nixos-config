{
  default, pkgs, inputs, ...
}:
{

  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];

  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    plugins = {
	    nvim-cmp.enable = true;
	    chadtree.enable = true;
	    treesitter.enable = true;
	    telescope.enable = true;
	    indent-blankline.enable = true;
	    which-key.enable = true;
      lsp = {
        enable = true;
        servers = {
          rust-analyzer.enable = true;
          nixd.enable = true;
          rnix-lsp.enable = true;
          lua-ls.enable = true;
          html.enable = true;
          cssls.enable = true;
          gdscript.enable = true;
          bashls.enable = true;
          clangd.enable = true;
        };
      };
    };
    extraPlugins = with pkgs.vimPlugins; [
	    vim-parinfer
	    vim-nix
	    yuck-vim
    ];
  };
}
