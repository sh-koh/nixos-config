{ config, inputs, ... }:
{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./keymaps.nix
    ./plugins
  ];

  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
    clipboard = {
      providers.wl-copy.enable = true;
      register = "unnamedplus";
    };
    opts = {
      title = true;
      number = true;
      relativenumber = true;
      hidden = true;

      splitbelow = true;
      splitright = true;
      modeline = true;
      swapfile = false;
      modelines = 100;
      undofile = true;
      incsearch = true;
      inccommand = "split";

      shiftwidth = 2;
      tabstop = 2;
      softtabstop = 2;
      expandtab = true;
      autoindent = true;
      smartindent = true;
      breakindent = true;

      updatetime = 100;
      timeoutlen = 100;
      list = true;
      hlsearch = true;
      scrolloff = 10;

      termguicolors = true;
      signcolumn = "yes";
      cursorline = true;
      showmode = false;
    };
    highlight = with config.lib.stylix.colors.withHashtag; {
      WinSeparator.fg = base02;
      DashboardHeader.fg = base08;
    };
  };
}
