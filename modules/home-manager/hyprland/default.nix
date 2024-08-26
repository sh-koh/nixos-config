{
  config,
  pkgs,
  lib,
  self',
  ...
}:
{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = [
        "HDMI-A-1,preferred,0x0,auto"
        "DP-1,highrr,2560x0,auto"
        "eDP-1,2160x1440@60,0x0,1.5"
      ];

      workspace = [
        "11, monitor:DP-1, default:true"
        "1, monitor:eDP-1, default:true"
        "1, monitor:HDMI-A-1, default:true"
      ];

      windowrulev2 = [
        "noborder, class:^(Xdg-desktop-portal-gtk)$"
        "noblur, class:^(Xdg-desktop-portal-gtk)$"
        "dimaround, class:^(Xdg-desktop-portal-gtk)$"
        "noshadow, class:^(Xdg-desktop-portal-gtk)$"

        "noshadow, class:^(polkit-gnome-authentication-agent-1)$"
        "noblur, class:^(polkit-gnome-authentication-agent-1)$"
        "dimaround, class:^(polkit-gnome-authentication-agent-1)$"
        "stayfocused, class:^(polkit-gnome-authentication-agent-1)$"
      ];

      exec-once = [
        "${pkgs.systemd}/bin/systemctl --user import-environment PATH"
        "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1 &"
      ];

      input = {
        kb_layout = "us";
        kb_variant = "intl";
        numlock_by_default = true;
        repeat_rate = 50;
        repeat_delay = 300;
        follow_mouse = 1;
        sensitivity = 0;
        accel_profile = "flat";
        touchpad = {
          clickfinger_behavior = true;
          tap-to-click = true;
          natural_scroll = true;
          disable_while_typing = false;
          drag_lock = true;
        };
      };

      render = {
        explicit_sync = 0;
        explicit_sync_kms = 0;
        direct_scanout = true;
      };

      opengl = {
        nvidia_anti_flicker = false;
        force_introspection = 0;
      };

      cursor = {
        default_monitor = "DP-1";
      };

      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 1;
        layout = "master";
        allow_tearing = true;
      };

      decoration = {
        rounding = 3;
        drop_shadow = true;
        shadow_range = 4;
        shadow_render_power = 3;
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
        };
      };

      animations = {
        enabled = true;
        bezier = [ "myBezier, 0, 0.8, 0, 1.0" ];

        animation = [
          "windows, 1, 3, myBezier"
          "windowsOut, 1, 3, default, popin 80%"
          "border, 1, 3, default"
          "borderangle, 1, 3, default"
          "fade, 1, 3, default"
          "workspaces, 1, 3, default"
        ];
      };

      group = {
        groupbar = {
          font_family = "Lexend";
          font_size = 10;
        };
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master = {
        new_status = "master";
        new_on_top = true;
        mfact = 0.6;
        allow_small_split = true;
      };

      gestures = {
        workspace_swipe = true;
        workspace_swipe_fingers = 3;
        workspace_swipe_create_new = true;
        workspace_swipe_use_r = true;
      };

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        disable_autoreload = true;
        force_default_wallpaper = 0;
        mouse_move_enables_dpms = true;
        key_press_enables_dpms = true;
        focus_on_activate = true;
        initial_workspace_tracking = 1;
        vrr = 1;
      };

      plugin = {
        xwaylandprimary = {
          display = "DP-1";
        };
      };

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      bindl = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 2.5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 2.5%-"
      ];

      "$mainMod" = "SUPER";
      "$terminal" = "kitty -1";
      "$fileManager" = "nautilus";
      "$menu" = "anyrun";

      bind =
        let
          layoutSwitcher = lib.getExe (
            pkgs.writeShellApplication {
              name = "layout-switcher.sh";
              runtimeInputs = with pkgs; [
                hyprland
                jq
              ];
              text = ''
                case $(hyprctl -j getoption general:layout | jq -r '.str') in 
                  "master") hyprctl keyword general:layout dwindle ;;
                  "dwindle") hyprctl keyword general:layout master ;;
                esac
              '';
            }
          );

          getActiveMonitor = lib.getExe (
            pkgs.writeShellApplication {
              name = "get-active-monitor.sh";
              runtimeInputs = with pkgs; [
                satty
                grim
                jq
                hyprland
              ];
              text = ''
                grim -o "$(hyprctl -j monitors all | \
                  jq -r '.[] | select(.focused == true) | .name')" - | \
                  satty --filename - \
                    --fullscreen \
                    --early-exit \
                    --copy-command "wl-copy" \
                    --initial-tool "crop"
              '';
            }
          );
        in
        [
          "$mainMod, Return, exec, $terminal"
          "$mainMod, Space, exec, $menu"
          "$mainMod, E, exec, $fileManager"

          "$mainMod SHIFT, Q, exit,"
          "$mainMod, I, exec, ${layoutSwitcher}"
          "$mainMod, W, killactive,"
          "$mainMod, B, fullscreen"
          "$mainMod, F, pin, active"
          "$mainMod, mouse:274, togglefloating"

          "$mainMod, G, togglegroup"
          "$mainMod, Y, changegroupactive, b"
          "$mainMod, U, changegroupactive, f"
          "$mainMod SHIFT, Y, movegroupwindow, b"
          "$mainMod SHIFT, U, movegroupwindow, f"

          "$mainMod CTRL, Period, movewindow, mon:+1"
          "$mainMod CTRL, Comma, movewindow, mon:-1"
          "$mainMod SHIFT, Period, movewindow, mon:+1 silent"
          "$mainMod SHIFT, Comma, movewindow, mon:-1 silent"
          "$mainMod, Period, focusmonitor, +1"
          "$mainMod, Comma, focusmonitor, -1"

          # Dwindle
          "$mainMod, P, pseudo,"
          "$mainMod, O, togglesplit,"
          "$mainMod, left, movefocus, l"
          "$mainMod, down, movefocus, d"
          "$mainMod, up, movefocus, u"
          "$mainMod, right, movefocus, r"
          "$mainMod SHIFT, left, movewindow, l"
          "$mainMod SHIFT, down, movewindow, d"
          "$mainMod SHIFT, up, movewindow, u"
          "$mainMod SHIFT, right, movewindow, r"

          # Master
          "$mainMod SHIFT, Return, layoutmsg, swapwithmaster"
          "$mainMod, L, layoutmsg, mfact +0.05"
          "$mainMod, H, layoutmsg, mfact -0.05"
          "$mainMod SHIFT, L, layoutmsg, removemaster"
          "$mainMod SHIFT, H, layoutmsg, addmaster"
          "$mainMod, J, layoutmsg, cyclenext"
          "$mainMod, K, layoutmsg, cycleprev"
          "$mainMod SHIFT, J, layoutmsg, swapnext"
          "$mainMod SHIFT, K, layoutmsg, swapprev"
          "$mainMod ALT, H, layoutmsg, orientationleft"
          "$mainMod ALT, L, layoutmsg, orientationright"
          "$mainMod ALT, K, layoutmsg, orientationtop"
          "$mainMod ALT, J, layoutmsg, orientationbottom"

          "$mainMod SHIFT, S, exec, ${getActiveMonitor}"
        ]
        ++ (builtins.concatLists (
          builtins.genList (
            x:
            let
              ws =
                let
                  c = (x + 1) / 10;
                in
                builtins.toString (x + 1 - (c * 10));
            in
            [
              "$mainMod, ${ws}, split:workspace, ${toString (x + 1)}"
              "$mainMod CTRL, ${ws}, split:movetoworkspace, ${toString (x + 1)}"
              "$mainMod SHIFT, ${ws}, split:movetoworkspacesilent, ${toString (x + 1)}"
            ]
          ) 9
        ));
    };
    plugins = with self'.packages; [
      hyprXPrimary
      hyprsplit
    ];
  };
}
