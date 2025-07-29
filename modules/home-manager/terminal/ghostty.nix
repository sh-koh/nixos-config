{ lib, inputs', ... }:
{
  programs.ghostty = {
    enable = true;
    installBatSyntax = true;
    installVimSyntax = true;
    clearDefaultKeybinds = true;
    settings = {
      auto-update = "off";
      gtk-single-instance = true;
      gtk-adwaita = false;
      shell-integration-features = "cursor,sudo,title";
      linux-cgroup = "always";
      # FIXME: Available next release i guess, it enables opacity within TUI application.
      # background-opacity-cells = true;
      keybind = [
        "ctrl+shift+enter=toggle_split_zoom"

        "ctrl+alt+s=new_split:down"
        "ctrl+shift+s=new_split:right"
        "ctrl+alt+w=close_surface"
        "ctrl+alt+h=goto_split:left"
        "ctrl+alt+j=goto_split:down"
        "ctrl+alt+k=goto_split:up"
        "ctrl+alt+l=goto_split:right"

        "ctrl+alt+plus=equalize_splits"
        "ctrl+alt+up=resize_split:up,10"
        "ctrl+alt+down=resize_split:down,10"
        "ctrl+alt+right=resize_split:right,10"
        "ctrl+alt+left=resize_split:left,10"

        "alt+tab=toggle_tab_overview"

        "ctrl+shift+t=new_tab"
        "ctrl+shift+w=close_tab"
        "ctrl+shift+tab=previous_tab"
        "ctrl+shift+left=previous_tab"
        "ctrl+page_up=previous_tab"
        "ctrl+shift+right=next_tab"
        "ctrl+page_down=next_tab"
        "ctrl+tab=next_tab"

        "ctrl+shift+page_up=jump_to_prompt:-1"
        "ctrl+shift+page_down=jump_to_prompt:1"

        "alt+one=goto_tab:1"
        "alt+two=goto_tab:2"
        "alt+three=goto_tab:3"
        "alt+four=goto_tab:4"
        "alt+five=goto_tab:5"
        "alt+six=goto_tab:6"
        "alt+seven=goto_tab:7"
        "alt+eight=goto_tab:8"
        "alt+nine=last_tab"

        "ctrl+zero=reset_font_size"
        "ctrl+minus=decrease_font_size:1"
        "ctrl+equal=increase_font_size:1"

        "ctrl+shift+a=select_all"
        "ctrl+insert=copy_to_clipboard"
        "ctrl+shift+c=copy_to_clipboard"
        "ctrl+shift+v=paste_from_clipboard"
      ];
    };
  };
}
