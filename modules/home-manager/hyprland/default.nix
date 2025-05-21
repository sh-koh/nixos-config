{
  config,
  pkgs,
  lib,
  inputs',
  ...
}:
{
  wayland.windowManager.hyprland = {
    enable = true;
    systemd = {
      enable = false;
      enableXdgAutostart = false;
    };
    settings = {
      monitor = [
        "HDMI-A-1,preferred,0x0,auto"
        "DP-1,highrr,2560x0,auto"
        "eDP-1,2160x1440@60,0x0,1.5"
      ];

      workspace = [
        "1, monitor:HDMI-A-1, default:true"
        "11, monitor:DP-1, default:true"
        "1, monitor:eDP-1, default:true"

        "w[t1], gapsout:0, gapsin:0"
        "w[tg1], gapsout:0, gapsin:0"
        "f[1], gapsout:0, gapsin:0"
      ];

      layerrule = [
        "dimaround, ^(anyrun)$"
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

        "tile, class:^(XIVLauncher.Core)$"

        "float, initialTitle:^(Picture-in-Picture)$"
        "move 100%-w-0 0%-w-0, initialTitle:^(Picture-in-Picture)$"
        "size 533 300, initialTitle:^(Picture-in-Picture)$"
        "pin , initialTitle:^(Picture-in-Picture)$"

        "immediate, class:^(steam_app_.*)$"
        "immediate, class:^(gamescope)$"
        "immediate, class:^(Minecraft.*)$"
        "immediate, class:^(osu\\!)$"
        "immediate, class:^(overwatch\.exe)$"
        "immediate, class:^(ffxiv_dx11\.exe)$"

        "bordersize 0, floating:0, onworkspace:w[t1]"
        "rounding 0, floating:0, onworkspace:w[t1]"
        "bordersize 0, floating:0, onworkspace:w[tg1]"
        "rounding 0, floating:0, onworkspace:w[tg1]"
        "bordersize 0, floating:0, onworkspace:f[1]"
        "rounding 0, floating:0, onworkspace:f[1]"

        # App dispatch
        "workspace 1, class:^(zen)$"
        "workspace 2, class:^(vesktop)$"
        "workspace 3, class:^(thunderbird)$"
        "workspace ${
          if config.home.sessionVariables.HOSTNAME == "atrebois" then "19" else "9"
        }, class:^(steam)$"
      ];

      input = {
        kb_layout = "us";
        kb_variant = "intl";
        kb_options = if config.home.sessionVariables.HOSTNAME != "atrebois" then "ctrl:swapcaps" else null;
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
        explicit_sync = 1;
        explicit_sync_kms = 1;
        direct_scanout = true;
      };

      opengl = {
        nvidia_anti_flicker = false;
      };

      cursor = {
        no_hardware_cursors = true;
        use_cpu_buffer = false;
        default_monitor = "DP-1";
      };

      general = {
        gaps_in = 3;
        gaps_out = 6;
        border_size = 1;
        "col.inactive_border" = lib.mkForce "rgb(${config.lib.stylix.colors.base02})";
        "col.active_border" = lib.mkForce "rgb(${config.lib.stylix.colors.base03})";
        layout = "master";
        allow_tearing = true;
        snap = {
          enabled = true;
          window_gap = 5;
          monitor_gap = 10;
          border_overlap = false;
        };
      };

      decoration = {
        rounding = 0;
        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
        };
        blur = {
          enabled = true;
          ignore_opacity = false;
          size = 3;
          passes = 2;
          noise = 0.25;
        };
      };

      animations = {
        enabled = true;
        first_launch_animation = false;
        bezier = [
          "myBezier, 0.85, 0, 0.15, 1"
        ];

        animation = [
          "global, 1, 3, myBezier"

          "windows, 1, 1, myBezier"
          "windowsIn, 1, 1, myBezier, popin"
          "windowsOut, 1, 1, myBezier, popin"
          "windowsMove, 1, 3, myBezier"

          "layers, 1, 3, myBezier"
          "layersIn, 1, 3, myBezier"
          "layersOut, 1, 3, myBezier"

          "fade, 1, 3, myBezier"
          "fadeIn, 1, 1, myBezier"
          "fadeOut, 1, 1, myBezier"
          "fadeSwitch, 1, 3, myBezier"
          "fadeShadow, 1, 3, myBezier"
          "fadeDim, 1, 3, myBezier"
          "fadeLayers, 1, 3, myBezier"
          "fadeLayersIn, 1, 3, myBezier"
          "fadeLayersOut, 1, 3, myBezier"

          "border, 1, 1, myBezier"
          "borderangle, 1, 1, myBezier, once"

          "workspaces, 1, 3, myBezier, slidevert"
          "workspacesIn, 1, 3, myBezier, slidevert"
          "workspacesOut, 1, 3, myBezier, slidevert"

          "specialWorkspace, 1, 3, myBezier"
          "specialWorkspaceIn, 1, 3, myBezier"
          "specialWorkspaceOut, 1, 3, myBezier"
        ];
      };

      group = {
        groupbar = {
          font_family = config.stylix.fonts.serif.name;
          font_size = config.stylix.fonts.sizes.desktop;
        };
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master = {
        new_status = "master";
        new_on_top = true;
        mfact = 0.65;
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
        middle_click_paste = false;
        render_unfocused_fps = 60;
        vrr = 2;
        vfr = true;
      };

      plugin = { };

      exec-once = [
        "uwsm finalize"
        (
          if config.home.sessionVariables.HOSTNAME != "atrebois" then
            "${lib.getExe pkgs.xorg.xrandr} --output eDP-1 --primary"
          else
            "${lib.getExe pkgs.xorg.xrandr} --output DP-1 --primary"
        )
      ];

      bindm = [
        "SUPER, mouse:272, movewindow"
        "SUPER, mouse:273, resizewindow"
      ];

      bindl = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 1%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-"
      ];

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

          screenshotActiveMonitor = lib.getExe (
            pkgs.writeShellApplication {
              name = "screenshot-active-monitor.sh";
              runtimeInputs = with pkgs; [
                satty
                grim
                jq
                config.wayland.windowManager.hyprland.package
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

          UWSMApp = cmd: "${lib.getExe pkgs.uwsm} app -- ${lib.getExe cmd}";
        in
        [
          "SUPER, Return, exec, ${UWSMApp config.programs.kitty.package} -1"
          "SUPER, Space, exec, ${UWSMApp config.programs.anyrun.package}"
          "SUPER, E, exec, ${UWSMApp pkgs.nautilus}"
          "SUPER, Escape, exec, ${UWSMApp config.programs.ags.package} toggle Panel-$(${lib.getExe' config.wayland.windowManager.hyprland.package "hyprctl"} monitors -j | ${lib.getExe pkgs.jq} -r '.[] | select(.focused == true) | .id')"

          "SUPER ALT, S, exec, ${lib.getExe' pkgs.systemd "systemctl"} suspend"
          "SUPER ALT, Q, exec, ${lib.getExe pkgs.uwsm} stop"
          "SUPER SHIFT, Q, exec, ${lib.getExe' pkgs.systemd "loginctl"} lock-session"
          "SUPER, I, exec, ${layoutSwitcher}"
          "SUPER, W, killactive,"
          "SUPER, B, fullscreen"
          "SUPER, F, pin, active"
          "SUPER, mouse:274, togglefloating"

          "SUPER, G, togglegroup"
          "SUPER, Y, changegroupactive, b"
          "SUPER, U, changegroupactive, f"
          "SUPER SHIFT, Y, movegroupwindow, b"
          "SUPER SHIFT, U, movegroupwindow, f"

          "SUPER CTRL, Period, movewindow, mon:+1"
          "SUPER CTRL, Comma, movewindow, mon:-1"
          "SUPER SHIFT, Period, movewindow, mon:+1 silent"
          "SUPER SHIFT, Comma, movewindow, mon:-1 silent"
          "SUPER, Period, focusmonitor, +1"
          "SUPER, Comma, focusmonitor, -1"

          # Dwindle
          "SUPER, P, pseudo,"
          "SUPER, O, togglesplit,"
          "SUPER, left, movefocus, l"
          "SUPER, down, movefocus, d"
          "SUPER, up, movefocus, u"
          "SUPER, right, movefocus, r"
          "SUPER SHIFT, left, movewindow, l"
          "SUPER SHIFT, down, movewindow, d"
          "SUPER SHIFT, up, movewindow, u"
          "SUPER SHIFT, right, movewindow, r"

          # Master
          "SUPER SHIFT, Return, layoutmsg, swapwithmaster"
          "SUPER, L, layoutmsg, mfact +0.05"
          "SUPER, H, layoutmsg, mfact -0.05"
          "SUPER SHIFT, L, layoutmsg, removemaster"
          "SUPER SHIFT, H, layoutmsg, addmaster"
          "SUPER, J, layoutmsg, cyclenext"
          "SUPER, K, layoutmsg, cycleprev"
          "SUPER SHIFT, J, layoutmsg, swapnext"
          "SUPER SHIFT, K, layoutmsg, swapprev"
          "SUPER ALT, H, layoutmsg, orientationleft"
          "SUPER ALT, L, layoutmsg, orientationright"
          "SUPER ALT, K, layoutmsg, orientationtop"
          "SUPER ALT, J, layoutmsg, orientationbottom"

          "SUPER SHIFT, S, exec, ${screenshotActiveMonitor}"
        ]
        ++ (builtins.concatLists (
          builtins.genList (
            x:
            let
              ws =
                let
                  c = (x + 1) / 10;
                in
                toString (x + 1 - (c * 10));
            in
            [
              "SUPER, ${ws}, split:workspace, ${toString (x + 1)}"
              "SUPER CTRL, ${ws}, split:movetoworkspace, ${toString (x + 1)}"
              "SUPER SHIFT, ${ws}, split:movetoworkspacesilent, ${toString (x + 1)}"
            ]
          ) 9
        ));
      ecosystem = {
        no_update_news = true;
        no_donation_nag = true;
      };
    };
    plugins = [
      pkgs.hyprlandPlugins.hyprsplit
    ];
  };

  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        disable_loading_bar = false;
        hide_cursor = false;
        grace = 5;
        ignore_empty_input = true;
        immediate_render = false;
        text_trim = true;
      };

      auth = {
        pam = {
          enabled = true;
          module = "hyprlock";
        };
        fingerprint = {
          enabled = true;
          ready_message = "Scan fingerprint to unlock.";
          present_message = "Scanning fingerprint...";
        };
      };

      background = {
        blur_passes = 3;
        blur_size = 8;
      };

      image = {
        path = builtins.toString (
          pkgs.fetchurl {
            url = "https://avatars.githubusercontent.com/u/70974710?v=4";
            hash = "sha256-HAQYSeKEk3pjleDruExUzvqyXJGBI6t6+BZDQ/ex5B8=";
          }
        );
        size = 150;
        rounding = -1; # -1 = circle
        border_size = 1;
        position = "0, 130";
        halign = "center";
        valign = "center";
      };

      label = {
        text =
          lib.strings.toUpper (builtins.head (lib.strings.stringToCharacters config.home.username))
          + lib.strings.concatStrings (builtins.tail (lib.strings.stringToCharacters config.home.username)); # Uppercase firt letter
        font_size = 24;
        font_family = "Lexend";
        position = "0, 30";
        halign = "center";
        valign = "center";
      };

      input-field = {
        size = "300, 40";
        dots_center = true;
        fade_on_empty = false;
        outline_thickness = 2;
        shadow_passes = 2;
        placeholder_text = "Password...";
        position = "0, -20";
        halign = "center";
        valign = "center";
      };
    };
  };

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        ignore_dbus_inhibit = false;
        ignore_systemd_inhibit = false;
        lock_cmd = "${lib.getExe' pkgs.procps "pidof"} hyprlock || ${lib.getExe pkgs.hyprlock} || cw";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };

      listener = [
        {
          timeout = 20 * 60;
          on-timeout = "loginctl lock-session";
        }
        {
          timeout = 25 * 60;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
        # {
        #   timeout = 45 * 60;
        #   on-timeout = "systemctl suspend";
        # }
      ];
    };
  };

  systemd.user.services = {
    hypridle.Unit.After = lib.mkForce "graphical-session.target";
    hyprpaper.Unit.After = lib.mkForce "graphical-session.target";
    hyprpolkitagent = {
      Install.WantedBy = [ "graphical-session.target" ];
      Unit = {
        Description = "Hyprpolkitagent - Polkit authentication agent";
        After = lib.mkForce "graphical-session.target";
      };
      Service = {
        ExecStart = "${pkgs.hyprpolkitagent}/libexec/hyprpolkitagent";
        Nice = "0";
        Restart = "on-failure";
        StartLimitIntervalSec = 60;
        StartLimitBurst = 60;
      };
    };
  };

  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
      desktop = null;
      documents = "${config.home.homeDirectory}/Documents";
      download = "${config.home.homeDirectory}/Downloads";
      music = null;
      pictures = "${config.home.homeDirectory}/Pictures";
      publicShare = null;
      templates = null;
      videos = null;
    };
    portal = {
      enable = true;
      xdgOpenUsePortal = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-hyprland
        xdg-desktop-portal-gtk
      ];
      config.common.default = [
        "hyprland"
        "gtk"
      ];
    };
    autostart = {
      enable = true;
      entries = map (p: "${p}/share/applications/${p.meta.mainProgram}.desktop") [
        inputs'.zen-browser-flake.packages.zen-browser
        pkgs.thunderbird
        config.programs.vesktop.package
      ];
    };
  };
}
