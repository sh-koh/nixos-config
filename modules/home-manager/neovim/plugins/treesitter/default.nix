{
  programs.nixvim.plugins = {
    treesitter = {
      enable = true;
      nixvimInjections = true;
      settings = {
        highlight.enable = true;
        incremental_selection.enable = true;
        indent.enable = true;
      };
    };
    treesitter-refactor = {
      enable = true;
      smartRename.enable = true;
      highlightCurrentScope.enable = false;
      navigation.enable = true;
    };
    treesitter-textobjects = {
      enable = true;
      move = {
        enable = true;
        disable = [ ];
        setJumps = true;
      };
      select = {
        enable = true;
        disable = [ ];
        includeSurroundingWhitespace = false;
        lookahead = true;
        selectionModes = { };
      };
      swap = {
        enable = true;
        disable = [ ];
      };
    };
  };
}
