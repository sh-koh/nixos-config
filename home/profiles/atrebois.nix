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
    #citra-canary # RIP :(
    dolphin-emu
    gpu-screen-recorder
    lutris
    osu-lazer-bin
    prismlauncher
    tetrio-desktop
    xivlauncher
    #yuzu-early-access # RIP :(
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
  
  xdg.dataFile = {
    proton-ge =
      let
        name = "GE-Proton9-1";
      in {
      recursive = false;
      target = "Steam/compatibilitytools.d/${name}";
      source = builtins.fetchTarball {
        url = "https://github.com/GloriousEggroll/proton-ge-custom/releases/download/${name}/${name}.tar.gz";
        sha256 = "1zc1c1scqnpxsfxj6micpgvn317k7gd48aya8m3c5v6nbi377nm1";
      };
    };
    #ulwgl = # WIP
    #  let
    #    name = "ULWGL-launcher";
    #    version = "0.1-RC3";
    #  in {
    #  recursive = false;
    #  target = "lutris/runners/wine/${name}-${version}";
    #  source = builtins.fetchTarball { # Cannot fetchTarball because of an unexpected number of top-level files. https://github.com/NixOS/nix/pull/9053
    #    url = "https://github.com/Open-Wine-Components/${name}/releases/download/${version}/${name}.tar.gz";
    #    sha256 = "0llri404f5q6acwyhvhlkzaf0nnapmdkrkrlqp4ff13dcg84sp72";
    #  };
    #};
  };
}
