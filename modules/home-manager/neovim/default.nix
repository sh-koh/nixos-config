{ config, inputs, ... }:
let
  inherit (inputs) nixvim;
in
{
  imports = [
    nixvim.homeManagerModules.nixvim
    ./coq.nix
    ./keymapping.nix
    ./lsp.nix
    ./lualine.nix
    ./telescope.nix
    ./treesitter.nix
  ];

  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    highlight.NormalNC.fg = "#${config.lib.stylix.colors.base04}";
    clipboard = {
      providers.wl-copy.enable = true;
      register = "unnamedplus";
    };
    opts = {
      number = true;
      relativenumber = true;
      shiftwidth = 2;
      tabstop = 2;
      updatetime = 300;
      termguicolors = true;
      signcolumn = "yes";
      expandtab = true;
      cursorline = true;
    };
    plugins = {
      nix.enable = true;
      which-key.enable = true;
      direnv.enable = true;
      tmux-navigator.enable = true;
      luasnip.enable = true;
      lint.enable = true;
      commentary.enable = true;
      neocord.enable = true;
      bufferline.enable = true;
      indent-blankline.enable = true;
    };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };
}
