{
  programs.zellij = {
    enable = true;
    #package = ;
    settings = {
      on_force_close = "quit";
      copy_command = "wl-copy";
      copy_on_select = false;
      ui = {
        pane_frames.rounded_corners = false;
      };
    };
  };
}
