{ pkgs
, config
, lib
, inputs
, outputs
, ...
}: {
  imports = [
    inputs.hyprland.homeManagerModules.default
  ];

  home.packages = with pkgs; [
    btop
    imv
    mpv
    wl-clipboard
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    settings = {
      monitor = [ 
        ",highrr,auto,auto"
        "DP-1,highrr,0x0,auto"
        "HDMI-A-1,preferred,-2560x0,auto"
        "eDP-1,1620x1080@60,0x0,1"
      ];

      workspace = [
        "11, monitor:DP-1, default:true"
        "1, monitor:eDP-1, default:true"
        "1, monitor:HDMI-A-1, default:true"
      ];

      windowrulev2 = [
        "immediate, class:^(osu\!)$"
      ];

      exec-once = [
        "${pkgs.swww}/bin/swww-daemon &"
        "${pkgs.swww}/bin/swww img ${config.stylix.image}"
        "${pkgs.mate.mate-polkit}/libexec/polkit-mate-authentication-agent-1 &"
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
      
      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
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
        bezier = [
          "myBezier, 0, 0.8, 0, 1.0"
        ];
        
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
        #"col.border_active" = ;
        #"col.border_inactive" = ;
        #"col.border_locked_active" = ;
        #"col.border_locked_inactive" = ;
        groupbar = {
          font_family = "Lexend";
          font_size = 10;
          #"col.active" = ;
          #"col.inactive" = ;
          #"col.locked_active" = ;
          #"col.locked_inactive" = ;
        };
      };
      
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };
      
      master = {
        new_is_master = true;
        new_on_top = true;
        mfact = 0.60;
        no_gaps_when_only = true;
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
        no_direct_scanout = false;
        vrr = 1;
        vfr = true;
        #initial_workspace_tracking = 2;
      };
      
      device = {
        name = "epic-mouse-v1";
        sensitivity = -0.5;
      };

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      bindl = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ];

      "$mainMod" = "SUPER";
      "$terminal" = "kitty -1";
      "$fileManager" = "nautilus";
      "$menu" = "anyrun";

      bind = [
        "$mainMod, Return, exec, $terminal"
        "$mainMod, Space, exec, $menu"
        "$mainMod, E, exec, $fileManager"

        "$mainMod SHIFT, Q, exit,"
        "$mainMod, W, killactive,"
        "$mainMod, B, fullscreen"
        "$mainMod, F, togglefloating,"
        "$mainMod, mouse:274, togglefloating"
        "$mainMod SHIFT, G, togglegroup"
        "$mainMod CTRL, H, changegroupactive, b"
        "$mainMod CTRL, L, changegroupactive, f"

        "$mainMod, I, exec, hyprctl keyword general:layout master"
        "$mainMod SHIFT, I, exec, hyprctl keyword general:layout dwindle"

        # Dwindle
        "$mainMod, P, pseudo,"
        "$mainMod, O, togglesplit,"

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
        
        "$mainMod, left, layoutmsg, orientationleft"
        "$mainMod, right, layoutmsg, orientationright"
        "$mainMod, up, layoutmsg, orientationtop"
        "$mainMod, down, layoutmsg, orientationbottom"

        "$mainMod CTRL, Period, split-changemonitor, next"
        "$mainMod CTRL, Comma, split-changemonitor, prev"
        "$mainMod SHIFT, Period, split-changemonitorsilent, next"
        "$mainMod SHIFT, Comma, split-changemonitorsilent, prev"
        "$mainMod, Period, focusmonitor, +1"
        "$mainMod, Comma, focusmonitor, -1"

        "$mainMod SHIFT, S, exec, ${lib.getExe pkgs.wayshot} -s \"$(${pkgs.slurp}/bin/slurp)\" --stdout | ${pkgs.wl-clipboard}/bin/wl-copy"
      ] ++ 
      (builtins.concatLists (builtins.genList (
        x: let
          ws = let
            c = (x + 1) / 10;
          in
            builtins.toString (x + 1 - (c * 10));
        in [
          "$mainMod, ${ws}, split-workspace, ${toString (x + 1)}"
          "$mainMod CTRL, ${ws}, split-movetoworkspace, ${toString (x + 1)}"
          "$mainMod SHIFT, ${ws}, split-movetoworkspacesilent, ${toString (x + 1)}"
        ]
      ) 9));
    };
    plugins = [
      inputs.smw.packages.${pkgs.system}.default
    ];
    extraConfig = ''
      exec-once = ${pkgs.xorg.xrandr}/bin/xrandr --output DP-1 --primary
    '';
  };
}
