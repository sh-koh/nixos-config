{
  programs.nixvim.plugins = {
    oil = {
      enable = true;
      settings = {
        default_file_explorer = true;
        cleanup_delay_ms = 2000;
        constrain_cursor = "editable"; # One of editable, name or false
        delete_to_trash = true;
        experimental_watch_for_changes = true;
        prompt_save_on_select_new_entry = true;
        skip_confirm_for_simple_edits = true;
        use_default_keymaps = false;
        ssh.border = "single";
        columns = [
          { __unkeyed = "permissions"; highlight = "DiffChange"; }
          { __unkeyed = "size"; highlight = "Label"; }
          { __unkeyed = "mtime"; highlight = "Boolean"; }
          { __unkeyed = "icon"; default_file = ""; directory = ""; highlight = "Directory"; add_padding = false; }
        ];
        float = {
          border = "single"; # One of none, single, double, rounded, solid, shadow or an array of 8 elemets ["╔" "═" "╗" "║" "╝" "═" "╚" "║"]
          max_height = 0;
          max_width = 0;
          padding = 2;
        };
        lsp_file_method = {
          autosave_changes = false;
          timeout_ms = 1000;
        };
        preview = {
          border = "single";
          max_height = 0.9;
          max_width = 0.9;
          min_height = [ 5 0.1 ]; # Means “the greater of 5 columns or 10% of total”
          min_width = [ 40 0.4 ];
          update_on_cursor_moved = true;
          width = null;
        };
        progress = {
          border = "single";
          max_height = 0.9;
          max_width = 0.9;
          min_height = [ 5 0.1 ];
          min_width = [ 40 0.4 ];
          minimized_border = "none";
          height = null;
          width = null;
        };
        view_options = {
          is_always_hidden = ''
              function(name, bufnr)
                return false
              end
          '';
          is_hidden_file = ''
              function(name, bufnr)
                return vim.startswith(name, ".")
              end
          '';
          natural_order = true;
          show_hidden = true;
          sort = [
            [ "type" "asc" ]
            [ "name" "asc" ]
          ];
        };
        win_options = {
          concealcursor = "nvic";
          conceallevel = 3;
          cursorcolumn = false;
          foldcolumn = "0";
          list = false;
          signcolumn = "no";
          spell = false;
          wrap = false;
        };
        keymaps = {
          "-" = "actions.parent";
          "<C-c>" = "actions.close";
          "<C-h>" = "actions.select_split";
          "<C-l>" = "actions.refresh";
          "<C-p>" = "actions.preview";
          "<C-s>" = "actions.select_vsplit";
          "<C-t>" = "actions.select_tab";
          "<CR>" = "actions.select";
          _ = "actions.open_cwd";
          "`" = "actions.cd";
          "g." = "actions.toggle_hidden";
          "g?" = "actions.show_help";
          "g\\" = "actions.toggle_trash";
          gs = "actions.change_sort";
          gx = "actions.open_external";
          "~" = "actions.tcd";
        };
      };
    };
  };
}
