{
  triggers = [
    # Leader triggers
    {
      mode = "n";
      keys = "<Leader>";
    }
    {
      mode = "x";
      keys = "<Leader>";
    }

    # Built-in completion
    {
      mode = "i";
      keys = "<C-x>";
    }

    # `g` key
    {
      mode = "n";
      keys = "g";
    }
    {
      mode = "x";
      keys = "g";
    }

    # Marks
    {
      mode = "n";
      keys = "'";
    }
    {
      mode = "n";
      keys = "`";
    }
    {
      mode = "x";
      keys = "'";
    }
    {
      mode = "x";
      keys = "`";
    }

    # Registers
    {
      mode = "n";
      keys = "\"";
    }
    {
      mode = "x";
      keys = "\"";
    }
    {
      mode = "i";
      keys = "<C-r>";
    }
    {
      mode = "c";
      keys = "<C-r>";
    }

    # Window commands
    {
      mode = "n";
      keys = "<C-w>";
    }

    # `z` key
    {
      mode = "n";
      keys = "z";
    }
    {
      mode = "x";
      keys = "z";
    }
  ];

  window = {
    delay = 500;
    scroll_down = "<Tab>";
    scroll_up = "<S-Tab>";
  };

  clues = {
    # Enhance this by adding descriptions for <Leader> mapping groups
    "__unkeyed-1.cmp".__raw = "require('mini.clue').gen_clues.builtin_completion()";
    "__unkeyed-2.g".__raw = "require('mini.clue').gen_clues.g()";
    "__unkeyed-3.marks".__raw = "require('mini.clue').gen_clues.marks()";
    "__unkeyed-4.registers".__raw = "require('mini.clue').gen_clues.registers()";
    "__unkeyed-5.windows".__raw = "require('mini.clue').gen_clues.windows()";
    "__unkeyed-6.z".__raw = "require('mini.clue').gen_clues.z()";
  };
}
