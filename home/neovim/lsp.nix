{ config
, pkgs
, lib
, inputs
, outputs
, ...
}: {

  programs.nixvim.plugins.lsp = {
    enable = true;
    servers = {
      nixd = {
	      enable = true;
	      settings.formatting.command = "alejandra";
      };
      nil_ls.enable = true;
      gopls.enable = true;
      ruff-lsp.enable = true;
      dockerls.enable = true;
      html.enable = true;
      tsserver.enable = true;
      cssls.enable = true;
      bashls.enable = true;
      phpactor.enable = true;
      pylsp.enable = true;
      terraformls.enable = true;
      lua-ls.enable = true;
      jsonls.enable = true;
    };
  };
}
