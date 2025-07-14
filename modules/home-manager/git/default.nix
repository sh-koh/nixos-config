{
  config,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    inputs.pogit.homeManagerModules.default
  ];

  home.packages = with pkgs; [
    act
    gist
    gitflow
  ];

  programs = {
    git = {
      enable = true;
      package = pkgs.gitFull;
      lfs.enable = true;
      delta.enable = true;
      userName = "sh-koh";
      userEmail = "70974710+sh-koh@users.noreply.github.com";
      extraConfig = {
        init.defaultBranch = "master";
        push.autoSetupRemote = true;
        pull.rebase = true;
        url = {
          "ssh://git@github.com/sh-koh".insteadOf = "https://github.com/sh-koh";
          "ssh://git@gitlab.com/sh-koh".insteadOf = "https://gitlab.com/sh-koh";
        };
      };
    };

    ssh = {
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

    pogit = {
      inherit (config.programs.git) enable;
      config = {
        /*
          %i = icon
          %t = type (nix, norm, fix, etc.)
          %d = denominator (surrounded by parenthesis)
          %m = commit message
        */
        # format = "[%i] %t%d: %m"; # TODO: fix upstream
        nix = {
          icon = "❄️";
          msg = "nix related changes.";
        };
        revert = {
          icon = "🔄";
          msg = "reverted some changes.";
        };
        update = {
          icon = "💡";
          msg = "updated!";
        };
      };
    };
  };
}
