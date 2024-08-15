{
  programs.nixvim.plugins = {
    lualine = {
      enable = true;
      globalstatus = true;
      iconsEnabled = true;
      sectionSeparators = {
        left = "";
        right = "";
      };
      componentSeparators = {
        left = "|";
        right = "|";
      };
    };
  };
}
