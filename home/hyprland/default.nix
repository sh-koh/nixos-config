{ config
, pkgs
, lib
, theme
, inputs
, outputs
, ...
}:
{ wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = with config.lib.stylix.colors; ''
      monitor = DP-1, 1920x1080@240, auto, 1
      monitor = HDMI-1-A, 2560x1080@60, auto, 1

      exec-once = eww open-many bar clock date
      exec-once = dunst
      exec-once = swww init
      exec-once = sleep 2 && swww img ${config.stylix.image}
      exec-once = firefox
      exec-once = sleep 3 && noisetorch -i
      exec-once = xrandr --output DP-1 --primary
      exec-once = /nix/store/$(ls -la /nix/store | grep 'mate-polkit' | grep '4096' | awk '{print $9}' | sed -n '$p')/libexec/polkit-mate-authentication-agent-1

      input {
        kb_layout = us
        kb_variant = intl
        kb_model =
        kb_options =
        kb_rules =
        follow_mouse = 1
        sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
        force_no_accel = 1
        touchpad {
          natural_scroll = yes
        }
      }

      general {
        gaps_in = 3
        gaps_out = 6
        border_size = 1
        col.active_border = rgba(${base0B}ff)
        col.inactive_border = rgba(${base01}ff)
        layout = master
        no_cursor_warps = true
        no_border_on_floating = false
      }

      animations {
        enabled = yes
        bezier = myBezier, 0, 0.8, 0, 1.0
        animation = windows, 1, 3, myBezier, popin 50%
        animation = windowsOut, 1, 3, myBezier, popin 95%
        animation = windowsMove, 1, 3, myBezier
        animation = border, 1, 3, myBezier
        animation = borderangle, 1, 3, myBezier
        animation = fade, 1, 3, myBezier
        animation = workspaces, 1, 3, myBezier
      }

      decoration {
        blur {
          enabled = false
        }
      }

      misc {
        disable_hyprland_logo = true
        disable_splash_rendering = true
        vrr = 1
        mouse_move_enables_dpms = true
        key_press_enables_dpms = true
      }

      dwindle {
        pseudotile = yes
        preserve_split = no
      }

      master {
        new_is_master = true
        new_on_top = true
        mfact = 0.60
        no_gaps_when_only = true
        allow_small_split = true
      }

      gestures {
        workspace_swipe = on
      }

      # Variables
      $mainMod = SUPER

      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = $mainMod, mouse:272, movewindow
      bindm = $mainMod, mouse:273, resizewindow

      # Binds
      bind = $mainMod, Tab, exec, $HOME/.config/hypr/layoutswitch
      bind = $mainMod, Return, exec, kitty -1
      bind = $mainMod, W, killactive
      bind = $mainMod SHIFT, Q, exit
      bind = $mainMod, Space, exec, anyrun
      bind = $mainMod, mouse:274, togglefloating
      bind = $mainMod, I, pseudo # dwindle
      bind = $mainMod, J, togglesplit # dwindle
      bind = $mainMod, b, fullscreen
      bind = $mainMod, k, layoutmsg, cycleprev
      bind = $mainMod, l, layoutmsg, cyclenext
      bind = $mainMod SHIFT, Return, layoutmsg, swapwithmaster
      bind = $mainMod SHIFT, S, exec, slurp | grim -g - - | wl-copy
      bind = $mainMod, A, splitratio, -0.05
      bind = $mainMod, S, splitratio, +0.05
      bind = $mainMod, P, workspace, m+1
      bind = $mainMod, O, workspace, m-1

      # Binding workspaces for hyprsome
      workspace = 1, monitor:HDMI-1-A, default:true
      workspace = 2, monitor:HDMI-1-A
      workspace = 3, monitor:HDMI-1-A
      workspace = 4, monitor:HDMI-1-A
      workspace = 5, monitor:HDMI-1-A
      workspace = 6, monitor:HDMI-1-A
      workspace = 7, monitor:HDMI-1-A
      workspace = 8, monitor:HDMI-1-A
      workspace = 9, monitor:HDMI-1-A
      workspace = 11, monitor:DP-1, default:true
      workspace = 12, monitor:DP-1
      workspace = 13, monitor:DP-1
      workspace = 14, monitor:DP-1
      workspace = 15, monitor:DP-1
      workspace = 16, monitor:DP-1
      workspace = 17, monitor:DP-1
      workspace = 18, monitor:DP-1
      workspace = 19, monitor:DP-1

      # Switch workspaces 
      bind = $mainMod, 1, exec, hyprsome workspace 1
      bind = $mainMod, 2, exec, hyprsome workspace 2
      bind = $mainMod, 3, exec, hyprsome workspace 3
      bind = $mainMod, 4, exec, hyprsome workspace 4
      bind = $mainMod, 5, exec, hyprsome workspace 5
      bind = $mainMod, 6, exec, hyprsome workspace 6
      bind = $mainMod, 7, exec, hyprsome workspace 7
      bind = $mainMod, 8, exec, hyprsome workspace 8
      bind = $mainMod, 9, exec, hyprsome workspace 9

      # Take active window with you to a workspace with Mod + Ctrl 
      bind = $mainMod CTRL, 1, exec, hyprsome movefocus 1
      bind = $mainMod CTRL, 2, exec, hyprsome movefocus 2
      bind = $mainMod CTRL, 3, exec, hyprsome movefocus 3
      bind = $mainMod CTRL, 4, exec, hyprsome movefocus 4
      bind = $mainMod CTRL, 5, exec, hyprsome movefocus 5
      bind = $mainMod CTRL, 6, exec, hyprsome movefocus 6
      bind = $mainMod CTRL, 7, exec, hyprsome movefocus 7
      bind = $mainMod CTRL, 8, exec, hyprsome movefocus 8
      bind = $mainMod CTRL, 9, exec, hyprsome movefocus 9

      # Send active window to a workspace with Mod + Shift
      bind = $mainMod SHIFT, 1, exec, hyprsome move 1
      bind = $mainMod SHIFT, 2, exec, hyprsome move 2
      bind = $mainMod SHIFT, 3, exec, hyprsome move 3
      bind = $mainMod SHIFT, 4, exec, hyprsome move 4
      bind = $mainMod SHIFT, 5, exec, hyprsome move 5
      bind = $mainMod SHIFT, 6, exec, hyprsome move 6
      bind = $mainMod SHIFT, 7, exec, hyprsome move 7
      bind = $mainMod SHIFT, 8, exec, hyprsome move 8
      bind = $mainMod SHIFT, 9, exec, hyprsome move 9

      workspace = HDMI-A-1, 1
      workspace = DP-1, 11
    '';
  };
}
