{ pkgs, config, lib, ... }: {

  programs.zsh = {
    enable = true;
    defaultKeymap = "viins";
    autocd = true;
    enableVteIntegration = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    historySubstringSearch = {
      enable = true;
      searchUpKey = "^p";
      searchDownKey = "^o";
    };
    history = {
      extended = true;
      ignoreDups = true;
      ignoreAllDups = true;
      ignoreSpace = true;
      expireDuplicatesFirst = true;
    };
    shellAliases = {
      ".." = "cd ..";
      "..." = "cd ../../";
      "...." = "cd ../../../";
      "....." = "cd ../../../../";

      ls = "${lib.getExe pkgs.eza} --color=auto --icons=auto --git --smart-group --modified --git-repos-no-status --mounts";
      ll = "${lib.getExe pkgs.eza} --color=auto --icons=auto --git --smart-group --modified --git-repos-no-status --mounts --tree --level 1";
      l = "${lib.getExe pkgs.eza} --color=auto --icons=auto --git --smart-group --modified --header --long --git-repos-no-status --mounts --all";
      cd = "z";
      cat = "${lib.getExe pkgs.bat} --style=auto --color=auto --paging=never";
      less = "${lib.getExe pkgs.bat} --style=auto --color=auto --paging=always";
      diff = "diff --color=auto";
      find = "${lib.getExe pkgs.fd} -H";
      grep = "${lib.getExe pkgs.ripgrep} -SpnH";
      zj = "${lib.getExe pkgs.zellij} $@ options --no-pane-frames --simplified-ui=true";
    };
    initExtra = ''
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
      zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"
      zstyle ':completion:*' menu no
      zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
      zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
    '';
    plugins = [
      {
        name = "fzf-tab";
        src = "${pkgs.zsh-fzf-tab}/share/fzf-tab";
      }
    ];
  };
}
