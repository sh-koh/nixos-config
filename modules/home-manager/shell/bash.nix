{
  lib,
  pkgs,
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
    shellAliases =
      with lib;
      with pkgs;
      {
        cat = "${getExe bat} --style=auto --color=auto --paging=never --tabs=2 --wrap=never";
        cd = "__zoxide_z";
        fd = "${getExe fd} -H";
        less = "${getExe bat} --style=auto --color=auto --paging=always --number --tabs=2 --wrap=never";
        rg = "${getExe ripgrep} -SpnH";
        untar = "tar xpvf";
        mktar = "tar czvf";
      };
  };
}
