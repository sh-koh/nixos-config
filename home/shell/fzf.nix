{ pkgs, config, lib, ... }:
{
  programs.fzf = {
    enable = true;
    defaultCommand = "${lib.getExe pkgs.fd} -H --type f";
    defaultOptions = ["--height 50%"];
    fileWidgetCommand = "${config.programs.fzf.defaultCommand}";
    fileWidgetOptions = [
      "--preview '${lib.getExe pkgs.bat} --color=always --plain --line-range=:200 {}'"
    ];
    changeDirWidgetCommand = "${lib.getExe pkgs.fd} -H --type d";
    changeDirWidgetOptions = ["--preview '${pkgs.tree}/bin/tree -C {} | head -200'"];
    historyWidgetOptions = [];
    tmux = {
      enableShellIntegration = true;
      shellIntegrationOptions = [
        ""
      ];
    };
  };
}
