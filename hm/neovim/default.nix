{ pkgs
, lib
, config
, inputs
, outputs
, ...
}: {
  imports = [ inputs.nixvim.homeManagerModules.nixvim ];

  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    clipboard.providers.wl-copy.enable = true;
    options = {
      number = true;
      relativenumber = true;
    };
    plugins = {
      barbar = { enable = true; animation = true; autoHide = false; };
      nix = { enable = true; };
      telescope = { enable = true; };
      treesitter = { enable = true; };
      undotree = { enable = true; };
      which-key = { enable = true; };
      lsp = { enable = true; servers.nixd.enable = true; };
    };
    extraPlugins = with pkgs.vimPlugins; [
      vimsence
      yuck-vim
    ];
  };
}
