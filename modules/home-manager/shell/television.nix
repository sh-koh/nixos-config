{
  lib,
  pkgs,
  config,
  ...
}:
{
  programs.television = {
    enable = true;
    settings = {
      tick_rate = 50;
      #default_channel = "files";
      #history_size = 200;
      #global_history = false;
      #input_bar_position = "top";
      #input_prompt = ">";
      #orientation = "landscape";
      #preview_size = 50;
      ui = {
        use_nerd_font_icons = true;
        ui_scale = 100;
        features = {
          preview_panel = {
            enabled = true;
            visible = true;
          };
          help_panel = {
            enabled = true;
            visible = false;
          };
          status_bar = {
            enabled = true;
            visible = true;
          };
          remote_control = {
            enabled = true;
            visible = false;
          };
        };
        status_bar = {
          separator_open = "";
          separator_close = "";
        };
        preview_panel = {
          size = 50;
          # header = "{}";
          # footer = "";
          scrollbar = true;
        };
        remote_control = {
          show_channel_descriptions = true;
          sort_alphabetically = true;
        };
      };
      # keybindings = {
      #   quit = [
      #     "esc"
      #     "ctrl-c"
      #   ];
      #   select_next_entry = [
      #     "down"
      #     "ctrl-n"
      #     "ctrl-j"
      #   ];
      #   select_prev_entry = [
      #     "up"
      #     "ctrl-p"
      #     "ctrl-k"
      #   ];
      #   select_prev_page = "alt-up";
      #   select_next_page = "alt-down";
      #   toggle_selection_down = "tab";
      #   toggle_selection_up = "backtab";
      #   confirm_selection = "enter";
      #   scroll_preview_half_page_down = [
      #     "alt-j"
      #     "pagedown"
      #   ];
      #   scroll_preview_half_page_up = [
      #     "alt-k"
      #     "pageup"
      #   ];
      #   copy_entry_to_clipboard = "ctrl-y";
      #   toggle_remote_control = "ctrl-t";
      #   toggle_preview = "ctrl-o";
      #   toggle_help = "ctrl-h";
      # };
      shell_integration = {
        fallback_channel = "files";
        channel_triggers = {
          "alias" = [
            "alias"
            "unalias"
          ];
          "env" = [
            "export"
            "unset"
            "set"
          ];
          "zoxide" = [
            "cd"
          ];
          "dirs" = [
            "ls"
            "rmdir"
          ];
          "files" = [
            "bat"
            "cat"
            "less"
            "head"
            "tail"
            "nvim"
            "cp"
            "mv"
            "rm"
            "touch"
            "chmod"
            "chown"
            "ln"
            "tar"
            "mktar"
            "untar"
            "zip"
            "unzip"
            "gzip"
            "gunzip"
            "xz"
          ];
          "git-diff" = [
            "git add"
            "git restore"
          ];
          "git-branch" = [
            "git checkout"
            "git branch"
            "git merge"
            "git rebase"
            "git pull"
            "git push"
          ];
          "git-log" = [
            "git log"
            "git show"
          ];
          "docker-images" = [ "docker run" ];
          "git-repos" = [
            "nvim"
            "git clone"
          ];
        };
        keybindings = {
          "smart_autocomplete" = "ctrl-t";
          "command_history" = "ctrl-r";
        };
      };
    };
    channels = {
      "nix" = {
        metadata.name = "nix";
        source.command = "${lib.getExe pkgs.nix-search-tv} print";
        preview.command = "${lib.getExe pkgs.nix-search-tv} preview {}";
      };
      "zoxide" = {
        metadata.name = "zoxide";
        source.command = "${lib.getExe pkgs.zoxide} query -l";
        preview.command = "${lib.getExe pkgs.eza} -la --color=always {}";
      };
    };
  };

  programs.television.settings.ui.theme =
    if config.programs.television.enable then "stylix" else null;
  xdg.configFile."television/themes/stylix.toml" = {
    enable = config.programs.television.enable;
    text = with config.lib.stylix.colors.withHashtag; ''
      background = '${base00}'
      border_fg = '${base03}'
      text_fg = '${base07}'
      dimmed_text_fg = '${base04}'

      input_text_fg = '${base0D}'
      result_count_fg = '${base0D}'

      result_name_fg = '${base06}'
      result_line_number_fg = '${base0A}'
      result_value_fg = '${base0B}'

      selection_fg = '${base0D}'
      selection_bg = '${base02}'
      match_fg = '${base0B}'

      preview_title_fg = '${base09}'

      channel_mode_fg = '${base08}'
      channel_mode_bg = '${base00}'
      remote_control_mode_fg = '${base01}'
      remote_control_mode_bg = '${base08}'
      send_to_channel_mode_fg = '${base0E}'
    '';
  };
}
