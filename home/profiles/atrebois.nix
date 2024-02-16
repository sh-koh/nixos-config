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
    #cemu
    citra-canary
    dolphin-emu
    gpu-screen-recorder
    lutris
    osu-lazer-bin
    prismlauncher
    tetrio-desktop
    xivlauncher
    yuzu-early-access
    (pkgs.writeShellScriptBin "replay-buffer" ''
      SCREEN=DP-1
      FPS=60
      BUFFER=120
      FORMAT="mp4"
      AUDIO_OUTPUT="alsa_output.usb-Logitech_PRO_X_000000000000-00.analog-stereo.monitor"
      AUDIO_INPUT="alsa_input.usb-Logitech_PRO_X_000000000000-00.mono-fallback"
      CLIPS_PATH=/media/SSHD/Clips
      
      if [[ $(pidof gpu-screen-recorder) == "" ]]; then
        dunstify "Started replay buffer..."
        gpu-screen-recorder \
          -w $SCREEN \
          -f $FPS \
          -r $BUFFER \
          -c $FORMAT \
          -a "$AUDIO_OUTPUT|$AUDIO_INPUT" \
          -o $CLIPS_PATH
      else
        dunstify "Stopped replay buffer."
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
  
  xdg.dataFile = {
    #wine-ge =
    #  let
    #    version = "GE-Proton8-25";
    #    name = "wine-lutris-${version}-x86_64";
    #  in {
    #  recursive = false;
    #  target = "lutris/runners/wine/${name}";
    #  source = builtins.fetchTarball {
    #    url = "https://github.com/GloriousEggroll/wine-ge-custom/releases/download/${version}/${name}.tar.xz";
    #    sha256 = "0hfdff58jdicxnabs7inynmxhbvxkd0a4jamwn10g91n8yh9c8nj";
    #  };
    #};
    proton-ge =
      let
        name = "GE-Proton8-30";
      in {
      recursive = false;
      target = "Steam/compatibilitytools.d/${name}";
      source = builtins.fetchTarball {
        url = "https://github.com/GloriousEggroll/proton-ge-custom/releases/download/${name}/${name}.tar.gz";
        sha256 = "1x9ra3115i2hv95fvnwqahd01wgfyc4id7z1yhrmpnk5m1ksb012";
      };
    };
  };
}
