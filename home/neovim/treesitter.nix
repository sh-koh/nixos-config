{ pkgs, config, lib, ... }: {
  
  programs.nixvim.plugins = {
    cmp-treesitter.enable = true;
    treesitter = {
      enable = true;
      nixvimInjections = true;
      incrementalSelection.enable = true;
    };
    treesitter-refactor = {
      enable = true;
      smartRename.enable = true;
      highlightCurrentScope.enable = true;
      navigation.enable = true;
    };
  };
}
