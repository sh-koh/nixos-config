{
  pkgs,
  lib,
  ...
}:
{
  imports = [ ./rustaceanvim.nix ];

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

          gopls = {
            enable = true;
            package = null;
          };
          hls = {
            enable = true;
            package = null;
            installGhc = false;
          };
          lua_ls = {
            enable = true;
            package = null;
          };
          ruff = {
            enable = true;
            package = null;
          };
          ts_ls = {
            enable = true;
            package = null;
          };
          zls = {
            enable = true;
            package = null;
          };

          dockerls = {
            enable = true;
            package = null;
          };
          ansiblels = {
            enable = true;
            package = null;
          };
          terraformls = {
            enable = true;
            package = null;
          };
          nginx_language_server = {
            enable = true;
            package = null;
          };

          yamlls.enable = true;
          jsonls.enable = true;
          taplo.enable = true;
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
