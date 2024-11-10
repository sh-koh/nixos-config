{
  programs.nixvim.plugins = {
    neorg = {
      enable = true;
      modules = {
        "core.defaults".__empty = null;
        "core.concealer".__empty = null;
        "core.completion".config.engine = "nvim-cmp";
        "core.dirman" = {
          config = {
            workspaces = {
              home = "~/Documents/org/home";
              work = "~/Documents/org/work";
            };
          };
        };
      };
    };
  };
}
