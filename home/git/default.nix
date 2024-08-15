{ pkgs, ... }:
{
  home.packages = with pkgs; [
    act
    gist
    gitflow
  ];

  programs.git = {
    enable = true;
    package = pkgs.gitFull;
    lfs.enable = true;
    delta.enable = true;
    userName = "sh-koh";
    userEmail = "70974710+sh-koh@users.noreply.github.com";
    extraConfig = {
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      pull.rebase = true;
      url = {
        "ssh://git@github.com/sh-koh".insteadOf = "https://github.com/sh-koh";
        "ssh://git@gitlab.com/sh-koh".insteadOf = "https://gitlab.com/sh-koh";
      };
      # ignores = [
      #   "result"
      #   ".direnv"
      #   "vendor"
      #   "tmp"
      #   "air"
      # ];
    };
  };

  programs.ssh = {
    addKeysToAgent = "yes";
    matchBlocks = {
      "github" = {
        host = "github.com";
        user = "git";
        identityFile = "~/.ssh/id_github";
      };
      "gitlab" = {
        host = "gitlab.com";
        user = "git";
        identityFile = "~/.ssh/id_gitlab";
      };
    };
  };
}
