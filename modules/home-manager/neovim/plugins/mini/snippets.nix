{
  # Array of snippets and loaders (see |MiniSnippets.config| for details).
  # Nothing is defined by default. Add manually to have snippets to match.
  snippets = { };

  # Module mappings. Use `""` (empty string) to disable one.
  mappings = {
    # Expand snippet at cursor position. Created globally in Insert mode.
    expand = "<C-j>";

    # Interact with default `expand.insert` session.
    # Created for the duration of active session(s)
    jump_next = "<C-l>";
    jump_prev = "<C-h>";
    stop = "<C-c>";
  };

  # Functions describing snippet expansion. If `nil` default values
  # are `MiniSnippets.default_<field>()`.
  expand = {
    # Resolve raw config snippets at context
    prepare = null;
    # Match resolved snippets at cursor position
    match = null;
    # Possibly choose among matched snippets
    select = null;
    # Insert selected snippet
    insert = null;
  };
}
