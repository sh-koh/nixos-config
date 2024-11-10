{
  programs.nixvim.plugins = {
    telescope = {
      enable = true;
      keymaps = {
        "<leader>f" = "find_files";
        "<leader>G" = "grep_string";
        "<leader>g" = "live_grep";
        "<leader>D" = "lsp_definitions";
        "<leader>d" = "diagnostics";
        "<leader>B" = "buffers";
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
              preview_width = 0.60;
              mirror = false;
            };
            vertical = {
              width = 0.40;
              height = 0.30;
              prompt_position = "top";
              mirror = false;
            };
          };
        };
        pickers = {
          find_files = {
            # ...
          };
        };
      };
    };
  };
}
