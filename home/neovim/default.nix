{ config, inputs , ... }:
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
    clipboard.providers.wl-copy.enable = true;
    clipboard.register = "unnamedplus";
    highlight.NormalNC.fg = "#${config.lib.stylix.colors.base04}";
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
      ccc.enable = true;
      chadtree.enable = true;
      neocord.enable = true;
      bufferline.enable = true;
      indent-blankline.enable = true;
    };
  };
}
