{
  # Module mappings. Use `""` (empty string) to disable one.
  mappings = {
    start = "ga";
    start_with_preview = "gA";
  };

  # Modifiers changing alignment steps and/or options
  modifiers = {
    # Main option modifiers
    #"s" = #<function: enter split pattern>;
    #"j" = #<function: choose justify side>;
    #"m" = #<function: enter merge delimiter>;

    # Modifiers adding pre-steps
    #"f" = #<function: filter parts by entering Lua expression>;
    #"i" = #<function: ignore some split matches>;
    #"p" = #<function: pair parts>;
    #"t" = #<function: trim parts>;

    # Delete some last pre-step
    #"<BS>" = #<function: delete some last pre-step>;

    # Special configurations for common splits
    #"=" = #<function: enhanced setup for "=">;
    #"," = #<function: enhanced setup for ",">,
    #"|" = #<function: enhanced setup for "|">;
    #" " = #<function: enhanced setup for " ">;
  };

  # Default options controlling alignment process
  options = {
    split_pattern = "";
    justify_side = "left";
    merge_delimiter = "";
  };

  # Default steps performing alignment (if `null`; default is used)
  steps = {
    pre_split = { };
    split = null;
    pre_justify = { };
    justify = null;
    pre_merge = { };
    merge = null;
  };

  # Whether to disable showing non-error feedback
  # This also affects (purely informational) helper messages shown after
  # idle time if user input is required.
  silent = false;
}
