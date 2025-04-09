{
  programs.nixvim.plugins = {
    mini = {
      enable = true;
      mockDevIcons = true;
      modules = {
        ai = import ./ai.nix;
        align = import ./align.nix;
        basics = import ./basics.nix;
        bracketed = import ./bracketed.nix;
        bufremove = import ./bufremove.nix;
        clue = import ./clue.nix;
        comment = import ./comment.nix;
        completion = import ./completion.nix;
        cursorword = import ./cursorword.nix;
        diff = import ./diff.nix;
        extra = import ./extra.nix;
        files = import ./files.nix;
        fuzzy = import ./fuzzy.nix;
        git = import ./git.nix;
        hipatterns = import ./hipatterns.nix;
        icons = import ./icons.nix;
        indentscope = import ./indentscope.nix;
        jump = import ./jump.nix;
        jump2d = import ./jump2d.nix;
        misc = import ./misc.nix;
        move = import ./move.nix;
        notify = import ./notify.nix;
        operators = import ./operators.nix;
        pairs = import ./pairs.nix;
        pick = import ./pick.nix;
        sessions = import ./sessions.nix;
        splitjoin = import ./splitjoin.nix;
        starter = import ./starter.nix;
        statusline = import ./statusline.nix;
        surround = import ./surround.nix;
        tabline = import ./tabline.nix;
        trailspace = import ./trailspace.nix;
        visits = import ./visits.nix;
      };
    };
  };
}
