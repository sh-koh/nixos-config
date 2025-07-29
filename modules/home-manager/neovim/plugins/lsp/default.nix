{
  pkgs,
  lib,
  ...
}:
{
  programs.nixvim = {
    plugins = {
      nix.enable = true;
      lsp = {
        enable = true;
        inlayHints = true;
        servers = {
          bashls.enable = true;
          nushell.enable = true;
          just.enable = true;
          nixd = {
            enable = true;
            settings =
              let
                flake = ''(builtins.getFlake ("git+file://" + builtins.toString ./.))'';
              in
              {
                formatting.command = [ "${lib.getExe pkgs.nixfmt-rfc-style}" ];
                nixpkgs.expr = "import ${flake}.inputs.nixpkgs {}";
                options = {
                  nixos.expr = ''(builtins.head (builtins.attrValues ${flake}.nixosConfigurations)).options'';
                  home-manager.expr = ''(builtins.head (builtins.attrValues ${flake}.homeConfigurations)).options'';
                };
              };
          };

          gopls.enable = true;
          hls = {
            enable = true;
            installGhc = false;
          };
          lua_ls.enable = true;
          ruff.enable = true;
          rust_analyzer = {
            enable = true;
            installRustc = false;
            installCargo = false;
          };
          ts_ls.enable = true;
          zls.enable = true;

          dockerls.enable = true;
          ansiblels.enable = true;
          terraformls = {
            enable = true;
            package = pkgs.tofu-ls;
          };
          nginx_language_server.enable = true;

          yamlls.enable = true;
          jsonls.enable = true;
          taplo.enable = true;
          sqls.enable = true;
          html.enable = true;
          cssls.enable = true;
          marksman.enable = true;
        };
      };
      lsp-format = {
        enable = true;
        lspServersToEnable = "all";
      };
    };
  };
}
