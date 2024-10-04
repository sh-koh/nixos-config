{ config, inputs, ... }:
{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
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
    keymaps = [{
      mode = "n";
      action.__raw = ''
        function()
          require('yazi').yazi()
        end
      '';
      key = "<leader><leader>";
      options = { silent = true; };
    }];
    plugins = {
      web-devicons.enable = true;
      direnv.enable = true;
      tmux-navigator.enable = true;
      luasnip.enable = true;
      lint.enable = true;
      commentary.enable = true;
      neogit.enable = true;
      nvim-autopairs.enable = true;

      bufferline = {
        enable = true;
      };

      neocord = {
        enable = true;
        settings = {
          logo = "auto";
          logo_tooltip = null;
          main_image = "language";
          enable_line_number = true;

          show_time = true;
          auto_update = true;

          editing_text = "Editing %s";
          file_explorer_text = "Browsing %s";
          git_commit_text = "Committing changes";
          plugin_manager_text = "Managing plugins";
          reading_text = "Reading %s";
          workspace_text = "Working on %s";
          line_number_text = "Line %s out of %s";
          terminal_text = "Using Terminal";
        };
      };

      yazi = {
        enable = true;
        settings = {
          enable_mouse_support = true;
          floating_window_scaling_factor = 0.8;
          log_level = "off";
          open_for_directories = true;
          yazi_floating_window_border = "single";
          yazi_floating_window_winblend = 0;
          keymaps = {
            show_help = "<f2>";
            copy_relative_path_to_selected_files = "<c-y>";
            cycle_open_buffers = "<tab>";
            grep_in_directory = "<c-s>";
            open_file_in_horizontal_split = "<c-x>";
            open_file_in_tab = "<c-t>";
            open_file_in_vertical_split = "<c-v>";
            replace_in_directory = "<c-g>";
            send_to_quickfix_list = "<c-q>";
          };
        };
      };

      dashboard = {
        enable = true;
        settings = {
          theme = "hyper";
          shortcut_type = "letter";
          config = {
            mru = {
              cwd_only = false;
              icon = " ";
              icon_hl = "Directory";
              label = " Files:";
              limit = 20;
            };
            project = {
              enable = true;
              action.__raw = ''
                function(path)
                  require("yazi").yazi(nil, path)
                end
              '';
              icon = "󰏓 ";
              icon_hl = "@function";
              label = " Projects:";
              limit = 20;
            };
            shortcut = [
              {
                action = "silent exec '!xdg-open https://github.com/sh-koh'";
                desc = "github";
                group = "@module.builtin";
                icon = " ";
                icon_hl = "@function";
                key = "z";
                key_hl = "@variable";
              }
              {
                action = "silent exec '!xdg-open https://gitlab.com/sh-koh'";
                desc = "gitlab";
                group = "@label";
                icon = " ";
                icon_hl = "@constant";
                key = "x";
                key_hl = "@variable";
              }
            ];
            header = [
              ""
              "⠀⠀⠀⠀⠀⠐⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
              "⠀⠀⠀⠀⠀⠀⠈⣾⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
              "⠀⠀⠀⠀⠀⠀⠀⢸⣇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
              "⠀⠀⠀⠀⠀⠀⠀⣈⣼⣄⣠⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
              "⠀⠀⠀⠀⠀⠀⠉⠑⢷⣿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
              "⠀⠀⠀⠀⠀⠀⠀⠀⣼⣐⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
              "⠀⠀⠀⠀⠀⠀⠀⠀⠘⡚⢧⠀⠀⠀⢠⠀⠀⠀⠀⠀⠀⠀⠀⠀"
              "⠀⠀⠀⠀⠀⠀⠀⠀⠀⢃⢿⡇⠀⠀⡾⡀⠀⠀⠀⠀⠀⠀⠀⠀"
              "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⠸⣇⠀⠀⠡⣰⠀⠀⠀⠀⠀⠀⠀⠀"
              "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠇⣿⠀⢠⣄⢿⠇⠀⠀⠀⠀⠀⠀⠀"
              "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⢸⡇⠜⣭⢸⡀⠀⠀⠀⠀⠀⠀⠀"
              "⠀⠀⠀⠀⠀⠀⠀⠀⣼⠀⡙⣿⣿⠰⢫⠁⣇⠀⠀⠀⠀⠀⠀⠀"
              "⠀⠀⠀⠀⠀⠀⠀⢰⣽⠱⡈⠋⠋⣤⡤⠳⠉⡆⠀⠀⠀⠀⠀⠀"
              "⠀⠀⠀⠀⠀⠀⠀⡜⠡⠊⠑⠄⣠⣿⠃⠀⣣⠃⠀⠀⠀⠀⠀⠀"
              "⠀⠀⠀⠀⠀⠐⣼⡠⠥⠊⡂⣼⢀⣤⠠⡲⢂⡌⡄⠀⠀⠀⠀⠀"
              "⠀⠀⠀⠀⣀⠝⡛⢁⡴⢉⠗⠛⢰⣶⣯⢠⠺⠀⠈⢥⠰⡀⠀⠀"
              "⠀⣠⣴⢿⣿⡟⠷⠶⣶⣵⣲⡀⣨⣿⣆⡬⠖⢛⣶⣼⡗⠈⠢⠀"
              "⢰⣹⠭⠽⢧⠅⢂⣳⠛⢿⡽⣿⢿⡿⢟⣟⡻⢾⣿⣿⡤⢴⣶⡃"
              ""
            ];
            footer = [
              "---"
              "Still waiting for Bloodborne on PC..."
            ];
          };
        };
      };

      which-key = {
        enable = true;
        settings = {
          win = {
            border = "single";
            #bg = config.lib.stylix.colors.withHashtag.base01;
          };
        };
      };

      indent-blankline = {
        enable = true;
        settings = {
          scope = {
            enabled = true;
            show_start = true;
          };
          exclude = {
            buftypes = [ "terminal" "nofile" ];
            filetypes = [ "help" "dashboard" ];
          };
        };
      };

      gitsigns = {
        enable = true;
        settings.signs = {
          add.text = "+";
          change.text = "~";
        };
      };

      nvim-colorizer = {
        enable = true;
        userDefaultOptions.names = false;
      };

      trim = {
        enable = true;
        settings = {
          highlight = true;
          ft_blocklist = [
            "checkhealth"
            "floaterm"
            "lspinfo"
            "TelescopePrompt"
            "dashboard"
            "yazi"
          ];
        };
      };
    };
  };
}
