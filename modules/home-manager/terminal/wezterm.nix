{ config, ... }:
{
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      return {
        animation_fps = ${
          {
            atrebois = "240";
            rocaille = "60";
          }
          .${config.home.sessionVariables.HOSTNAME}
        },
        audible_bell = 'Disabled',
        enable_wayland = true,
        front_end = 'OpenGL',
        hide_tab_bar_if_only_one_tab = true,
        tab_bar_at_bottom = true,
        term = 'wezterm',
        use_fancy_tab_bar = true,
        window_close_confirmation = 'NeverPrompt',
        window_decorations = 'NONE',
        window_padding = {
          top = 0,
          bottom = 0,
          left = 0,
          right = 0,
        },
      }
    '';
  };
}
