{ config, ... }:
{
  programs.zathura = {
    enable = true;
    options = {
      font = config.stylix.fonts.monospace.name + " " + (builtins.toString config.stylix.fonts.sizes.terminal);
      selection-notification = true;
      selection-clipboard = "clipboard";
      adjust-open = "best-fit";
      pages-per-row = "1";
      scroll-page-aware = "true";
      scroll-full-overlap = "0.01";
      scroll-step = "100";
      zoom-min = "10";
    };
  };
}
