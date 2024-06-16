{ programs.nixvim.plugins.lsp-format.enable = true;
  programs.nixvim.plugins.lsp = {
    enable = true;
    servers = {
      nixd.enable = true;
      nil-ls.enable = true;
      gopls.enable = true;
      ruff.enable = true;
      ruff-lsp.enable = true;
      dockerls.enable = true;
      docker-compose-language-service.enable = true;
      ansiblels.enable = true;
      yamlls.enable = true;
      jsonls.enable = true;
      taplo.enable = true;
      sqls.enable = true;
      html.enable = true;
      htmx.enable = true;
      tsserver.enable = true;
      cssls.enable = true;
      bashls.enable = true;
      nginx-language-server.enable = true;
      marksman.enable = true;
      phpactor.enable = true;
      terraformls.enable = true;
    };
  };
}
