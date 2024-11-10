{
  programs.nixvim.plugins = {
    nix.enable = true;
    lsp = {
      enable = true;
      servers = {
        bashls.enable = true; # Bash
        nushell.enable = true;
        nil_ls.enable = true; # Nix

        gopls.enable = true; # Go
        hls = { enable = true; installGhc = true; }; # Haskell
        lua_ls.enable = true; # Lua
        ruff.enable = true; # Python
        ruff_lsp.enable = true; # Python
        rust_analyzer = { enable = true; installRustc = true; installCargo = true; }; # Rust
        ts_ls.enable = true; # Typescript/Javascript
        zls.enable = true; # Zig

        dockerls.enable = true; # Docker
        docker_compose_language_service.enable = true; # Docker-compose
        ansiblels.enable = true; # Ansible
        terraformls.enable = true; # Terraform
        nginx_language_server.enable = true; # Nginx

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
    lsp-format = {
      enable = true;
      lspServersToEnable = "all";
    };
    lspkind = {
      enable = true;
      cmp.enable = true;
    };
  };
}
