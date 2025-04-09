{
  # Whether to open starter buffer on VimEnter. Not opened if Neovim was
  # started with intent to show something else.
  autoopen = true;

  # Whether to evaluate action of single active item
  evaluate_single = true;

  # Items to be displayed. Should be an array with the following elements:
  # - Item: table with <action>; <name>; and <section> keys.
  # - Function: should return one of these three categories.
  # - Array: elements of these three types (i.e. item; array; function).
  # If `null` (default); default items will be used (see |mini.starter|).
  items = {
    "__unkeyed-1.builtin_actions".__raw = "require('mini.starter').sections.builtin_actions()";
    "__unkeyed-2.recent_files_current_directory".__raw =
      "require('mini.starter').sections.recent_files(5, true)";
    "__unkeyed-3.recent_files".__raw = "require('mini.starter').sections.recent_files(5, false)";
    "__unkeyed-4.sessions".__raw = "require('mini.starter').sections.sessions(3, true)";
  };

  # Header to be displayed before items. Converted to single string via
  # `tostring` (use `\n` to display several lines). If function; it is
  # evaluated first. If `null` (default); polite greeting will be used.
  header = "";

  footer = "";

  # Array  of functions to be applied consecutively to initial content.
  # Each function should take and return content for "Starter" buffer (see
  # |mini.starter| and |MiniStarter.content| for more details).
  content_hooks = {
    "__unkeyed-1.adding_bullet".__raw = "require('mini.starter').gen_hook.adding_bullet()";
    "__unkeyed-2.indexing".__raw =
      "require('mini.starter').gen_hook.indexing('all', { 'Builtin actions' })";
    "__unkeyed-3.padding".__raw = "require('mini.starter').gen_hook.aligning('center', 'center')";
  };

  # Characters to update query. Each character will have special buffer
  # mapping overriding your global ones. Be careful to not add `:` as it
  # allows you to go into command mode.
  query_updaters = "abcdefghijklmnopqrstuvwxyz0123456789_-.";

  # Whether to disable showing non-error feedback
  silent = false;
}
