{ config, ... }:
{ 
  programs.kitty = {
    enable = true;
    shellIntegration.enableZshIntegration = true;
    settings = {
      font_family = "JetBrainsMono-Regular";
      bold_font = "JetBrainsMono-Bold";
      italic_font = "JetBrainsMono-Italic";
      bold_italic_font = "JetBrainsMono-BoldItalic";
      font_size = config.stylix.fonts.sizes.terminal;
      repaint_delay = 10;
      sync_to_monitor = "yes";
      confirm_os_window_close = 0;
      enable_audio_bell = 0;
    };
  };
}
