{
  # Delays (in ms; should be at least 1)
  delay = {
    # Delay between forcing asynchronous behavior
    async = 10;

    # Delay between computation start and visual feedback about it
    busy = 50;
  };

  # Keys for performing actions. See `:h MiniPick-actions`.
  mappings = {
    caret_left = "<C-b>";
    caret_right = "<C-n>";

    choose = "<CR>";
    choose_in_split = "<C-s>";
    choose_in_tabpage = "<C-t>";
    choose_in_vsplit = "<C-v>";
    choose_marked = "<C-CR>";

    delete_char = "<BS>";
    delete_char_right = "<Del>";
    delete_left = "<S-Del>";
    delete_word = "<C-Del>";

    mark = "<Tab>";
    mark_all = "<S-Tab>";

    move_down = "<C-j>";
    move_up = "<C-k>";
    move_start = "<C-h>";

    paste = "<C-r>";

    refine = "<C-Space>";
    refine_marked = "<M-Space>";

    scroll_down = "<M-j>";
    scroll_left = "<M-h>";
    scroll_right = "<M-l>";
    scroll_up = "<M-k>";

    stop = "<Esc>";

    toggle_info = "<C-z>";
    toggle_preview = "<C-x>";
  };

  # General options
  options = {
    # Whether to show content from bottom to top
    content_from_bottom = false;

    # Whether to cache matches (more speed and memory on repeated prompts)
    use_cache = true;
  };

  # Source definition. See `:h MiniPick-source`.
  source = {
    items = null;
    name = null;
    cwd = null;
    match = null;
    show = null;
    preview = null;
    choose = null;
    choose_marked = null;
  };

  # Window related options
  window = {
    # Float window config (table or callable returning it)
    config.__raw = ''
      function()
        local max_height = vim.o.lines - vim.o.cmdheight
        local max_width = vim.o.columns
        return {
          relative = 'editor',
          anchor = 'SW',
          width = math.floor(max_width),
          height = math.floor(0.36 * max_height),
          col = 0,
          row = max_height,
          border = 'single',
          style = 'minimal',
        }
      end
    '';

    # String to use as cursor in prompt
    prompt_caret = "▏";

    # String to use as prefix in prompt
    prompt_prefix = "> ";
  };
}
