{
  programs.nixvim.plugins = {
    neorg = {
      enable = true;
      settings = {
        load = {
          "core.defaults".__empty = null;
          "core.concealer".__empty = null;
          #"core.completion".config.engine = "mini.completion";
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
  };
}
