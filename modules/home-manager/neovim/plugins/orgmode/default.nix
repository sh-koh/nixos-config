{
  programs.nixvim.plugins = {
    orgmode = {
      enable = true;
      settings = {
        org_agenda_files = "~/Documents/org/**/*";
        org_default_notes_file = "~/Documents/org/notes.org";
      };
    };
  };
}
