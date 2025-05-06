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
        bashls.enable = true;
        nushell.enable = true;
        nixd = {
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

        gopls.enable = true;
        hls = {
          enable = true;
          installGhc = false;
        };
        lua_ls.enable = true;
        purescriptls = {
          enable = true;
          package = null;
        };
        ruff.enable = true;
        rust_analyzer = {
          enable = true;
          installRustc = false;
          installCargo = false;
        };
        ts_ls.enable = true;
        zls.enable = true;

        dockerls.enable = true;
        docker_compose_language_service.enable = true;
        ansiblels.enable = true;
        terraformls = {
          enable = true;
          package = pkgs.opentofu-ls;
        };
        nginx_language_server.enable = true;

        yamlls.enable = true;
        jsonls.enable = true;
        taplo.enable = true;
        sqls.enable = true;
        html.enable = true;
        htmx.enable = true;
        cssls.enable = true;
        marksman.enable = true;
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
