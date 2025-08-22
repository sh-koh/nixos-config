{
  lib,
  config,
  pkgs,
  inputs,
  inputs',
  ...
}:
{
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
      hooks = {
        prepare-commit-msg = lib.getExe (
          pkgs.writeShellApplication {
            name = "prepare-commit-msg-hook.sh";
            runtimeInputs = with pkgs; [ ];
            text = ''
              cat << 'EOF' >> "$1"
              # Commit types:
              # [🗑️] clean(_): cleaned project.
              # [✨] feat(_): added a very cool feature !
              # [🎉] init(_): hello world !
              # [✏️] norm(_): normed project.
              # [🚧] test(_): testing things, might broke.
              # [🏗️] wip(_): work in progress, not done yet.
              # [🔨] fix(_): fixed some things.
              # [📝] doc(_): added documentation.
              # [❄️] nix(_): nix related changes.
              # [🔄] revert(_): reverted some changes.
              # [💡] update(_): updated!
              EOF
            '';
          }
        );
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
  };
}
