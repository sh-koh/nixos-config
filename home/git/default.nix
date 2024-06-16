{ pkgs , ... }:
{
  programs.git = {
    enable = true;
    lfs.enable = true;

    userName = "sh-koh";
    userEmail = "70974710+sh-koh@users.noreply.github.com";
    package = pkgs.gitFull;

    extraConfig = {
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      pull.rebase = true;
      url = {
        "ssh://git@github.com/sh-koh" = {
          insteadOf = "https://github.com/sh-koh";
        };
        # "ssh://git@gitlab.com/" = {
        #   insteadOf = "https://gitlab.com/";
        # };
      };
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
