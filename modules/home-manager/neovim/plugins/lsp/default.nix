{
  pkgs,
  lib,
  ...
}:
{
  programs.nixvim.plugins = {
    nix.enable = true;
    lsp = {
      enable = true;
      inlayHints = true;
      servers = {
        bashls.enable = true; # Bash
        nushell.enable = true; # Nushell
        nixd = {
          # Nix
          enable = true;
          settings = {
            formatting.command = [ "${lib.getExe pkgs.nixfmt-rfc-style}" ];
            nixpkgs.expr = ''let flake = (builtins.getFlake ("git+file://" + builtins.toString ./.)).inputs; in import (builtins.head (builtins.attrValues flake)).inputs.nixpkgs {}'';
            options = {
              nixos.expr = ''let flake = (builtins.getFlake ("git+file://" + builtins.toString ./.)).nixosConfigurations; in (builtins.head (builtins.attrValues flake)).options'';
              home_manager.expr = ''let flake = (builtins.getFlake ("git+file://" + builtins.toString ./.)).homeConfigurations; in (builtins.head (builtins.attrValues flake)).options'';
              nixvim.expr = ''let flake = (builtins.getFlake ("git+file://" + builtins.toString ./.)).packages.${pkgs.system}.neovimNixvim; in (builtins.head (builtins.attrValues flake)).options'';
            };
          };
        };

        gopls.enable = true; # Go
        hls = {
          # Haskell
          enable = true;
          installGhc = false;
        };
        lua_ls.enable = true; # Lua
        ruff.enable = true; # Python
        rust_analyzer = {
          # Rust
          enable = true;
          installRustc = false;
          installCargo = false;
        };
        ts_ls.enable = true; # Typescript/Javascript
        zls.enable = true; # Zig

        dockerls.enable = true; # Docker
        docker_compose_language_service.enable = true; # Docker-compose
        ansiblels.enable = true; # Ansible
        terraformls = { # opentofu
          enable = true;
          #package = pkgs.opentofu-ls;
        };
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
