{
  # Content of statusline as functions which return statusline string. See
  # `:h statusline` and code of default contents (used instead of `null`).
  content = {
    # Content for active window
    active = null;
    # Content for inactive window(s)
    inactive = null;
  };

  # Whether to use icons by default
  use_icons = true;

  # Whether to set Vim's settings for statusline (make it always shown)
  set_vim_settings = true;
}
