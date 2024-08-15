{
  programs.nixvim.plugins.lsp-format.enable = true;
  programs.nixvim.plugins.lsp = {
    enable = true;
    servers = {
      bashls.enable = true; # Bash
      nixd.enable = true; # Nix

      hls.enable = true; # Haskell
      gopls.enable = true; # Go
      ruff.enable = true; # Python
      ruff-lsp.enable = true; # Python
      tsserver.enable = true; # Typescript/Javascript
      zls.enable = true; # Zig

      dockerls.enable = true; # Docker
      docker-compose-language-service.enable = true; # Docker-compose
      ansiblels.enable = true; # Ansible
      terraformls.enable = true; # Terraform
      nginx-language-server.enable = true; # Nginx

      yamlls.enable = true; # Yaml
      jsonls.enable = true; # JSON
      taplo.enable = true; # Toml
      sqls.enable = true; # SQL
      html.enable = true; # HTML
      htmx.enable = true; # HTMX
      cssls.enable = true; # CSS
      marksman.enable = true; # Markdown
    };
  };
}
