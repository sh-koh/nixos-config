{ config, lib, ... }:
{
  programs.nixvim = {
    plugins = {
      telescope = {
        enable = true;
        keymaps = {
          "<leader><leader>" = {
            action = "resume";
            options.desc = "Telescope resume";
          };
          "<leader>tf" = {
            action = "find_files";
            options.desc = "Telescope find files";
          };
          "<leader>tG" = {
            action = "grep_string";
            options.desc = "Telescope grep string";
          };
          "<leader>tg" = {
            action = "live_grep";
            options.desc = "Telescope live grep";
          };
          "<leader>tD" = {
            action = "lsp_definitions";
            options.desc = "Telescope definitions";
          };
          "<leader>td" = {
            action = "diagnostics";
            options.desc = "Telescope diagnostics";
          };
          "<leader>tb" = {
            action = "buffers";
            options.desc = "Telescope buffers";
          };
          "<leader>tr" = {
            action = "registers";
            options.desc = "Telescope registers";
          };
          "<leader>th" = {
            action = "help_tags";
            options.desc = "Telescope help";
          };
        };
        settings = {
          defaults = {
            mappings = {
              n = {
                "<CR>".__raw = ''
                  function(prompt_bufnr)
                    local picker = require('telescope.actions.state').get_current_picker(prompt_bufnr)
                    local multi = picker:get_multi_selection()

                    if vim.tbl_isempty(multi) then
                      require('telescope.actions').select_default(prompt_bufnr)
                      return
                    end

                    require('telescope.actions').close(prompt_bufnr)
                    for _, entry in pairs(multi) do
                      local filename = entry.filename or entry.value
                      local lnum = entry.lnum or 1
                      local lcol = entry.col or 1
                      if filename then
                        vim.cmd(string.format("edit +%d %s", lnum, filename))
                        vim.cmd(string.format("normal! %dG%d|", lnum, lcol))
                      end
                    end
                  end
                '';
              };
            };
            layout_strategy = "flex";
            layout_config = {
              preview_cutoff = 120;
              horizontal = {
                width = 0.70;
                height = 0.70;
                prompt_position = "bottom";
                preview_width = 0.40;
                mirror = false;
              };
              vertical = {
                width = 0.40;
                height = 0.30;
                prompt_position = "top";
                mirror = false;
              };
            };
            file_sorter.__raw = lib.mkIf config.programs.nixvim.plugins.mini.enable "require('mini.fuzzy').get_telescope_sorter";
            generic_sorter.__raw = lib.mkIf config.programs.nixvim.plugins.mini.enable "require('mini.fuzzy').get_telescope_sorter";
          };
          pickers = {
            find_files = {
              # ...
            };
          };
        };
      };
    };
    highlightOverride = with config.lib.stylix.colors.withHashtag; {
      TelescopeBorder.fg = base04;
    };
  };
}
