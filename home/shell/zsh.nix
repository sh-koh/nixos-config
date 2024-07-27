{ pkgs, lib, ... }:
{
  programs.zsh = {
    enable = true;
    defaultKeymap = "viins";
    autocd = true;
    enableVteIntegration = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting = {
      enable = true;
      highlighters = [
        "main"
        "brackets"
        "pattern"
        "cursor"
        "regexp"
        "root"
        "line"
      ];
    };

    historySubstringSearch = {
      enable = true;
      searchUpKey = "^k";
      searchDownKey = "^j";
    };

    history = {
      extended = true;
      ignoreDups = true;
      ignoreAllDups = true;
      ignoreSpace = true;
      expireDuplicatesFirst = true;
    };

    sessionVariables = {
      DIRENV_LOG_FORMAT = "";
      GOPATH = "$HOME/.local/share/go";
    };

    shellAliases =
      with lib;
      with pkgs; 
      {
      ".." = "cd ..";
      "..." = "cd ../../";
      "...." = "cd ../../../";
      "....." = "cd ../../../../";

      ls = "${getExe eza} --color=auto --icons=auto --git --smart-group --modified --git-repos-no-status --mounts";
      ll = "${getExe eza} --color=auto --icons=auto --git --smart-group --modified --header --long --git-repos-no-status --mounts";
      l = "${getExe eza} --color=auto --icons=auto --git --smart-group --modified --long --git-repos-no-status --mounts --all";
      cd = "z";
      cp = "cp -iv";
      mv = "mv -iv";
      du = "${getExe du-dust} -rb";
      cat = "${getExe bat} --style=auto --color=auto --paging=never --number --tabs=2 --wrap=never";
      less = "${getExe bat} --style=auto --color=auto --paging=always --number --tabs=2 --wrap=never";
      diff = "diff --color=auto";
      find = "${getExe fd} -H";
      grep = "${getExe ripgrep} -SpnH";
      untar = "tar xpvf";
      zj = "${getExe zellij} $@ options --no-pane-frames --simplified-ui=true";

      rebuild = "sudo nixos-rebuild";
    };

    initExtraBeforeCompInit = ''
      fpath+=(${pkgs.zsh-completions}/share/zsh/site-functions)
    '';

    completionInit = ''
      zstyle ':completion:*' use-cache on
      zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"

      zstyle ':completion:*' completer _extensions _complete _approximate

      zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
      zstyle ':completion:*:*:cd:*:directory-stack' menu yes select
      zstyle ':completion:*:-tilde-:*' group-order 'named-directories' 'path-directories' 'users' 'expand'
      zstyle ':completion:*:*:-command-:*:*' group-order aliases builtins functions commands
      zstyle ':completion:*' special-dirs true
      zstyle ':completion:*' squeeze-slashes true

      zstyle ':completion:*' sort false
      zstyle ":completion:*:git-checkout:*" sort false
      zstyle ':completion:*' file-sort modification
      zstyle ':completion:*:eza' sort false
      zstyle ':completion:complete:*:options' sort false
      zstyle ':completion:files' sort false

      zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
      zstyle ':completion:*' keep-prefix true
      zstyle ':completion:*' complete true
      zstyle ':completion:*' complete-options true
      zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"

      zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza --tree --level 1 --color=always --icons=always $realpath'
      zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza --tree --level 1 --color=always --icons=always $realpath'
      zstyle ':fzf-tab:*' fzf-command fzf
      zstyle ':fzf-tab:*' fzf-pad 4
      zstyle ':fzf-tab:*' fzf-min-height 100
      zstyle ':fzf-tab:*' switch-group ',' '.'
    '';

    plugins = map (name: {
      inherit name;
      src = pkgs.${"zsh-" + name};
      file = "share/${name}/${name}.plugin.zsh";
    }) [
      "fzf-tab"
      "abbr"
      "vi-mode"
    ] ++
    [
      {
        name = "forgit";
        src = pkgs.zsh-forgit;
        file = "share/zsh/zsh-forgit/forgit.plugin.zsh";
      }
    ];
  };
}
