{
  config,
  ...
}:
{
  programs.bat = {
    enable = true;
    config = {
      pager = "less -FR";
      theme = "base16-stylix";
    };
  };
}
