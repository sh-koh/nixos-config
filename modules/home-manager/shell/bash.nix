{
  config,
  ...
}:
{
  programs.bash = {
    enable = true;
    sessionVariables = {
      DIRENV_LOG_FORMAT = "";
      GOPATH = "${config.home.homeDirectory}/.local/share/go";
      NIXPKGS_ALLOW_UNFREE = if config.nixpkgs.config.allowUnfree then 1 else 0;
      PAGER = "${config.programs.bash.shellAliases.less}";
      EDITOR = "nvim";
    };
  };
}
