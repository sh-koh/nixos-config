{ config
, pkgs
, lib
, inputs
, outputs
, ...
}: {
  imports = [
    ./common.nix
  ];

  programs = {
    obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        obs-nvfbc
        obs-pipewire-audio-capture
        obs-vaapi
        obs-vkcapture
        obs-websocket
        wlrobs
      ];
    };
  };

  home.packages = with pkgs; [
    cemu
    #dolphin-emu
    gpu-screen-recorder
    #inputs.umu.packages.${pkgs.system}.umu
    lutris
    osu-lazer-bin
    prismlauncher
    ryujinx
    tetrio-desktop
    xivlauncher
    (pkgs.writeShellScriptBin "replay-buffer" ''
      SCREEN=DP-1
      FPS=60
      BUFFER=120
      FORMAT="mp4"
      AUDIO_OUTPUT="alsa_output.usb-Logitech_PRO_X_000000000000-00.analog-stereo.monitor"
      AUDIO_INPUT="alsa_input.usb-BIRD_UM1_BIRD_UM1-00.mono-fallback"
      CLIPS_PATH=/media/SSHD/Clips
      
      if [[ $(pidof gpu-screen-recorder) == "" ]]; then
        ${pkgs.libnotify}/bin/notify-send "Started replay buffer..."
        gpu-screen-recorder \
          -w $SCREEN \
          -f $FPS \
          -r $BUFFER \
          -c $FORMAT \
          -a "$AUDIO_OUTPUT|$AUDIO_INPUT" \
          -o $CLIPS_PATH
      else
        ${pkgs.libnotify}/bin/notify-send "Stopped replay buffer."
        killall gpu-screen-recorder
        gpu-screen-recorder \
          -w $SCREEN \
          -f $FPS \
          -r $BUFFER \
          -c $FORMAT \
          -a "$AUDIO_OUTPUT|$AUDIO_INPUT" \
          -o $CLIPS_PATH
      fi
    '')
  ];
}
