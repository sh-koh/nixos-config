{
  # Icon style: "glyph" or "ascii"
  style = "glyph";

  # Customize per category. See `:h MiniIcons.config` for details.
  default = { };
  directory = { };
  extension = { };
  file = { };
  filetype = { };
  lsp = { };
  os = { };

  # Control which extensions will be considered during "file" resolution
  use_file_extension.__raw = ''
    function(ext, file) return true end
  '';
}
