{
  config,
  ...
}:
{
  programs.bat = {
    enable = true;
    config = {
      pager = config.programs.bash.sessionVariables.PAGER;
    };
  };
}
