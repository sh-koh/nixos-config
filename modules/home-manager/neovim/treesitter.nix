{
  programs.nixvim.plugins = {
    treesitter = {
      enable = true;
      nixvimInjections = true;
      settings = {
        highlight.enable = true;
        incremental_selection.enable = true;
      };
    };
    treesitter-refactor = {
      enable = true;
      smartRename.enable = true;
      highlightCurrentScope.enable = true;
      navigation.enable = true;
    };
  };
}
