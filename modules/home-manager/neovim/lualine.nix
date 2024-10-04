{
  programs.nixvim.plugins.lualine = {
    enable = true;
    settings = {
      sections = {
        # +-------------------------------------------------+
        # | A | B | C                             X | Y | Z |
        # +-------------------------------------------------+
        lualine_a = [ "mode" ];
        lualine_b = [ "branch" "diff" ];
        lualine_c = [ "filename" ];
        # lualine_x = [  ];
        # lualine_y = [  ];
        # lualine_z = [  ];
      };
      options = {
        globalstatus = true;
        icons_enabled = true;
        section_separators = {
          left = "▓▒░";
          right = "░▒▓";
        };
        component_separators = {
          left = "|";
          right = "|";
        };
      };
    };
  };
}
