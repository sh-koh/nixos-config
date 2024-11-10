{
  programs.nixvim.plugins = {
    neocord = {
      enable = true;
      settings = {
        auto_update = true;
        blacklist = [ ];
        debounce_timeout = 10;
        editing_text = "Editing...";
        enable_line_number = true;
        file_assets = null;
        file_explorer_text = "Browsing...";
        git_commit_text = "Committing changes...";
        global_timer = false;
        line_number_text = "Line %s out of %s";
        log_level = null;
        logo = "auto";
        logo_tooltip = null;
        main_image = "language";
        plugin_manager_text = "Managing plugins...";
        reading_text = "Reading...";
        show_time = true;
        terminal_text = "Using Terminal...";
        workspace_text = "Working on %s";
        buttons = [
          {
            label = "Github";
            url = "https://github.com/sh-koh";
          }
          {
            label = "Gitlab";
            url = "https://gitlab.com/sh-koh";
          }
        ];
      };
    };
  };
}
