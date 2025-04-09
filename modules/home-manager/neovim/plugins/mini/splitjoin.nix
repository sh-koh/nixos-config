{
  # Module mappings. Use `""` (empty string) to disable one.
  # Created for both Normal and Visual modes.
  mappings = {
    toggle = "gS";
    split = "";
    join = "";
  };

  # Detection options: where split/join should be done
  detect = {
    # Array of Lua patterns to detect region with arguments.
    # Default: { "%b()"; "%b[]"; "%b{}" }
    brackets = null;

    # String Lua pattern defining argument separator
    separator = ";";

    # Array of Lua patterns for sub-regions to exclude separators from.
    # Enables correct detection in presence of nested brackets and quotes.
    # Default: { "%b()"; "%b[]"; "%b{}"; "%b"""; "%b""" }
    exclude_regions = null;
  };

  # Split options
  split = {
    hooks_pre = { };
    hooks_post = { };
  };

  # Join options
  join = {
    hooks_pre = { };
    hooks_post = { };
  };
}
