{
  lib,
  config,
  pkgs,
  inputs,
  inputs',
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
      userName = "sh-koh";
      userEmail = "70974710+sh-koh@users.noreply.github.com";
      package = pkgs.gitFull;
      lfs.enable = true;
      delta = {
        enable = true;
        options = {
          syntax-theme = "base16-stylix";
          dark = true;
          navigate = true;
          line-numbers = true;
          hyperlinks = true;
          side-by-side = true;
          color-moved = "default";
        };
      };
      extraConfig = {
        init.defaultBranch = "master";
        push.autoSetupRemote = true;
        pull.rebase = true;
        url = lib.concatMapAttrs (k: _v: {
          "ssh://git@${k}.com/${config.programs.git.userName}".insteadOf =
            "https://${k}.com/${config.programs.git.userName}";
        }) (lib.genAttrs [ "github" "gitlab" ] (x: x));
      };
    };

    ssh = {
      matchBlocks =
        lib.genAttrs
          [
            "github"
            "gitlab"
          ]
          (host: {
            host = "${host}.com";
            user = "git";
            identityFile = "~/.ssh/id_${host}";
          });
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
