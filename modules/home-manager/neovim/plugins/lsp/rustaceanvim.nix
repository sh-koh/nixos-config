{ config, ... }:
let
  tterm = config.programs.nixvim.plugins.toggleterm;
in
{
  programs.nixvim = {
    plugins = {
      rustaceanvim = {
        enable = true;
        settings = {
          tools = {
            executor = if tterm.enable then "toggleterm" else "quickfix";
            test_executor = if tterm.enable then "toggleterm" else "quickfix";
          };
        };
      };
    };
  };
}

