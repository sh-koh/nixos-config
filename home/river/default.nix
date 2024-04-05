{ config , pkgs , lib , ... }: {
  
  xdg.configFile = {
    "river/init" = {
      executable = true;
      text = with config.lib.stylix.colors; ''
        #!/usr/bin/env bash

        ${pkgs.dbus}/bin/dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY SWAYSOCK XDG_CURRENT_DESKTOP XDG_SESSION_TYPE NIXOS_OZONE_WL; systemctl --user start river-session.target

        # Remove mouse acceleration
        riverctl input pointer-1133-16505-Logitech_G_Pro accel-profile flat
        riverctl input pointer-1133-49288-Logitech_G_Pro_Wireless_Gaming_Mouse accel-profile flat

        # Cursor theme
        riverctl xcursor-theme ${config.home.pointerCursor.name} ${builtins.toString config.home.pointerCursor.size}

        # Audio bindings
        riverctl map normal None XF86AudioRaiseVolume spawn "wpctl set-volume @DEFAULT_SINK@ 2%+"
        riverctl map normal None XF86AudioLowerVolume spawn "wpctl set-volume @DEFAULT_SINK@ 2%-"

        # International keyboard layout
        riverctl keyboard-layout -variant intl us

        riverctl focus-follows-cursor always

        riverctl map normal Super Return spawn "${lib.getExe pkgs.kitty} -1"
        riverctl map normal Super Space spawn anyrun

        riverctl map normal Super+Shift Q exit
        riverctl map normal Super W close

        riverctl map normal Super+Shift S spawn '${lib.getExe pkgs.wayshot} -s "$(${lib.getExe pkgs.slurp})" --stdout | ${pkgs.wl-clipboard}/bin/wl-copy'

        # Super+J and Super+K to focus the next/previous view in the layout stack
        riverctl map normal Super J focus-view next
        riverctl map normal Super K focus-view previous

        # Super+Shift+J and Super+Shift+K to swap the focused view with the next/previous
        # view in the layout stack
        riverctl map normal Super+Shift J swap next
        riverctl map normal Super+Shift K swap previous

        # Super+Period and Super+Comma to focus the next/previous output
        riverctl map normal Super Period focus-output next
        riverctl map normal Super Comma focus-output previous

        # Super+Shift+{Period,Comma} to send the focused view to the next/previous output
        riverctl map normal Super+Shift Period send-to-output next
        riverctl map normal Super+Shift Comma send-to-output previous

        # Super+Return to bump the focused view to the top of the layout stack
        riverctl map normal Super+Shift Return zoom

        # Super+H and Super+L to decrease/increase the main ratio of rivertile(1)
        riverctl map normal Super H send-layout-cmd rivertile "main-ratio -0.05"
        riverctl map normal Super L send-layout-cmd rivertile "main-ratio +0.05"

        # Super+Shift+H and Super+Shift+L to increment/decrement the main count of rivertile(1)
        riverctl map normal Super+Shift H send-layout-cmd rivertile "main-count +1"
        riverctl map normal Super+Shift L send-layout-cmd rivertile "main-count -1"
  
        # Super+Alt+{H,J,K,L} to move views
        riverctl map normal Super+Alt H move left 100
        riverctl map normal Super+Alt J move down 100
        riverctl map normal Super+Alt K move up 100
        riverctl map normal Super+Alt L move right 100

        # Super+Alt+Shift+{H,J,K,L} to resize views
        riverctl map normal Super+Alt+Shift H resize horizontal -100
        riverctl map normal Super+Alt+Shift J resize vertical 100
        riverctl map normal Super+Alt+Shift K resize vertical -100
        riverctl map normal Super+Alt+Shift L resize horizontal 100

        # Super+Left Mouse Button to move views
        riverctl map-pointer normal Super BTN_LEFT move-view

        # Super+Right Mouse Button to resize views
        riverctl map-pointer normal Super BTN_RIGHT resize-view

        # Super+Middle Mouse Button or Super+F to toggle float
        riverctl map-pointer normal Super BTN_MIDDLE toggle-float
        riverctl map normal Super F toggle-float

        for i in {1..9}
        do
            tags=$((1 << ($i - 1)))

            # Super+[1-9] to focus tag [0-8]
            riverctl map normal Super $i set-focused-tags $tags

            # Super+Shift+[1-9] to tag focused view with tag [0-8]
            riverctl map normal Super+Shift $i set-view-tags $tags
  
            # Super+Control+[1-9] to toggle focus of tag [0-8]
            riverctl map normal Super+Control $i toggle-focused-tags $tags

            # Super+Shift+Control+[1-9] to toggle tag [0-8] of focused view
            riverctl map normal Super+Shift+Control $i toggle-view-tags $tags
        done

        # Super+0 to focus all tags
        # Super+Shift+0 to tag focused view with all tags
        all_tags=$(((1 << 32) - 1))
        riverctl map normal Super 0 set-focused-tags $all_tags
        riverctl map normal Super+Shift 0 set-view-tags $all_tags
  
        # Super+B to toggle fullscreen
        riverctl map normal Super B toggle-fullscreen

        # Super+{Up,Right,Down,Left} to change layout orientation
        riverctl map normal Super Up    send-layout-cmd rivertile "main-location top"
        riverctl map normal Super Right send-layout-cmd rivertile "main-location right"
        riverctl map normal Super Down  send-layout-cmd rivertile "main-location bottom"
        riverctl map normal Super Left  send-layout-cmd rivertile "main-location left"

        # Set background and border color
        riverctl background-color 0x000000
        riverctl border-width 1
        riverctl border-color-focused 0x${lib.removePrefix "#" base04}
        riverctl border-color-unfocused 0x${lib.removePrefix "#" base03}
	
	      # Server-side decoration
	      riverctl rule-add -app-id "firefox" ssd

        # Set keyboard repeat rate
        riverctl set-repeat 50 300

	      # Warp cusor on the focused view/output
	      riverctl set-cursor-warp on-focus-change
        
        # Set the default layout generator to be rivertile and start it.
        riverctl default-layout rivertile

        # Host specific config
        case $HOSTNAME in
            (atrebois)
                # GPU-screen-recorder replay saving
                riverctl map normal Super+Shift A spawn "killall -SIGUSR1 gpu-screen-recorder && dunstify 'Clip sauvegardé.'"

                wlr-randr --output DP-1 --mode 1920x1080@239.964005Hz --adaptive-sync enabled
                ${lib.getExe pkgs.xorg.xrandr} --output DP-1 --primary
            ;;
            (rocaille)
                wlr-randr --output eDP-1 --scale 1.5
                riverctl input pointer-2362-4918-HTIX5288:00_093A:1336_Touchpad natural-scroll enabled
                riverctl input pointer-2362-4918-HTIX5288:00_093A:1336_Touchpad tap enabled
            ;;
        esac

        swww init & 
        sleep 2 && swww img ${config.stylix.image} &
        ${pkgs.mate.mate-polkit}/libexec/polkit-mate-authentication-agent-1 &

        rivertile -view-padding 4 -outer-padding 4 &
      '';
    };
  };

  systemd.user.targets.river-session = {
    Unit = {
      Description = "river compositor session";
      Documentation = [ "man:systemd.special(7)" ];
      BindsTo = [ "graphical-session.target" ];
      Wants = [ "graphical-session-pre.target" ];
      After = [ "graphical-session-pre.target" ];
    };
  };

  home.packages = with pkgs; [
    btop
    imv
    mate.mate-polkit
    mpv
    river-bedload
    slurp
    swww
    wl-clipboard
    wlr-randr
  ];
}
