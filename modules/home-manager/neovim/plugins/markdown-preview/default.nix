{
  programs.nixvim = {
    keymaps = [
      {
        action = "<cmd>MarkdownPreviewToggle<CR>";
        key = "<leader>M";
        mode = "n";
        options = {
          silent = true;
          desc = "Toggle MarkdownPreview";
        };
      }
    ];
    plugins = {
      markdown-preview = {
        enable = true;
        settings = {
          auto_close = 0;
          theme = "dark";
          browser = "zen";
        };
      };
    };
  };
}
