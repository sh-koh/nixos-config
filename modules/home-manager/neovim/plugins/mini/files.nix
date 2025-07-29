{
  # Customization of shown content
  content = {
    # Predicate for which file system entries to show
    filter = null;
    # What prefix to show to the left of file system entry
    prefix = null;
    # In which order to show file system entries
    sort = null;
  };

  # Module mappings created only inside explorer.
  # Use `""` (empty string) to not create one.
  mappings = {
    close = "q";
    go_in = "L";
    go_in_plus = "<C-l>";
    go_out = "H";
    go_out_plus = "<C-h>";
    mark_goto = "m";
    mark_set = "M";
    reset = "<BS>";
    reveal_cwd = "@";
    show_help = "g?";
    synchronize = "<CR>";
    trim_left = "<";
    trim_right = ">";
  };

  # General options
  options = {
    # Whether to delete permanently or move into module-specific trash
    permanent_delete = true;
    # Whether to use for editing directories
    use_as_default_explorer = true;
  };

  # Customization of explorer windows
  windows = {
    # Maximum number of windows to show side by side
    max_number = 3;
    # Whether to show preview of file/directory under cursor
    preview = true;
    # Width of focused window
    width_focus = 45;
    # Width of non-focused window
    width_nofocus = 35;
    # Width of preview window
    width_preview = 75;
  };
}
