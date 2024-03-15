{ pkgs, config, lib, ... }: {

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      ls = "${lib.getExe pkgs.eza} --color=auto --icons=always --git --smart-group";
      l = "${lib.getExe pkgs.eza} --color=auto --icons=always --git --smart-group -la";
      cd = "z";
      cat = "${lib.getExe pkgs.bat} --style=auto --color=auto -P";
      less = "${lib.getExe pkgs.bat} --style=auto --color=auto";
      find = "${lib.getExe pkgs.fd} -H";
      grep = "${lib.getExe pkgs.ripgrep}";
      zj = "${lib.getExe pkgs.zellij} $@ options --no-pane-frames --simplified-ui=true";
    };
  };
}
