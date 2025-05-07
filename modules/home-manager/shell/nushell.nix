{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs.nushell = {
    enable = true;
    environmentVariables = config.programs.bash.sessionVariables;
    configFile = {
      text = ''
        $env.config = {
          show_banner: false
          error_style: "fancy"
          footer_mode: auto
          float_precision: 2
          use_ansi_coloring: true
          bracketed_paste: true
          edit_mode: vi # vi or emacs
          buffer_editor: "editor"
          use_kitty_protocol: true
          ls: {
            use_ls_colors: true
            clickable_links: true
          }
          table: {
            mode: basic_compact
            index_mode: always
            show_empty: true
            padding: { left: 1, right: 1 }
            header_on_separator: true # show header text on separator/border line
            trim: {
              methodology: wrapping # wrapping or truncating
              wrapping_try_keep_words: true # A strategy used by the 'wrapping' methodology
              truncating_suffix: "..." # A suffix used by the 'truncating' methodology
            }
          }
          history: {
            max_size: 1_000 # Session has to be reloaded for this to take effect
            sync_on_enter: true # Enable to share history between multiple sessions, else you have to close the session to write history to file
            file_format: "sqlite" # "sqlite" or "plaintext"
            isolation: false
          }
          completions: {
            case_sensitive: true # set to true to enable case-sensitive completions
            quick: true # set this to false to prevent auto-selecting completions when only one remains
            partial: true # set this to false to prevent partial filling of the prompt
            algorithm: "fuzzy" # prefix or fuzzy
            use_ls_colors: true
            external: {
              enable: true
              max_results: 50
            }
          }
          cursor_shape: {
            emacs: line # block, underscore, line, blink_block, blink_underscore, blink_line, inherit to skip setting cursor shape (line is the default)
            vi_insert: line # block, underscore, line, blink_block, blink_underscore, blink_line, inherit to skip setting cursor shape (block is the default)
            vi_normal: block # block, underscore, line, blink_block, blink_underscore, blink_line, inherit to skip setting cursor shape (underscore is the default)
          }
          menus: [
            {
              name: completion_menu
              only_buffer_difference: false # Search is done on the text written after activating the menu
              marker: "| "                  # Indicator that appears with the menu is active
              type: {
                  layout: columnar          # Type of menu
                  columns: 1                # Number of columns where the options are displayed
                  col_padding: 2            # Padding between columns
              }
              style: {
                  text: green                   # Text style
                  selected_text: green_reverse  # Text style for selected option
                  description_text: yellow      # Text style for description
              }
            }
            {
              name: history_menu
              only_buffer_difference: true
              marker: "+ "
              type: {
                layout: list
                page_size: 10
              }
              style: {
                text: green
                selected_text: green_reverse
                description_text: yellow
              }
            }
            {
              name: help_menu
              only_buffer_difference: true
              marker: "? "
              type: {
                layout: description
                columns: 4
                col_width: 20     # Optional value. If missing all the screen width is used to calculate column width
                col_padding: 2
                selection_rows: 4
                description_rows: 10
              }
              style: {
                text: green
                selected_text: green_reverse
                description_text: yellow
              }
            }
          ]
        }
      '';
    };
    # extraConfig = ''
    # '';

    envFile = {
      source = null;
      text = ''
        $env.PROMPT_INDICATOR_VI_NORMAL = "| "
        $env.PROMPT_INDICATOR_VI_INSERT = "> "
      '';
    };
    # extraEnv = ''
    # '';

    # loginFile = {
    #   source = null;
    #   text = null;
    # };
    # extraLogin = ''
    # '';
  };
}
