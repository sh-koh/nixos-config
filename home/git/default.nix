{ config
, pkgs
, lib
, ...
}: {
  programs.git = {
    enable = true;
    lfs.enable = true;

    userName = "sh-koh";
    userEmail = "abdel.briand.a@gmail.com";
    package = pkgs.gitFull;

    extraConfig = {
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      pull.rebase = true;

      # replace https with ssh
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
}
