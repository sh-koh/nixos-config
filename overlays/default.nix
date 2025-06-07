{ withSystem, ... }:
{
  flake.overlays = {
    modifications =
      _final: prev:
      withSystem prev.stdenv.hostPlatform.system (
        { ... }:
        {
          steam = prev.steam.override { extraArgs = "-pipewire -pipewire-dmabuf -system-composer"; };
          xivlauncher-rb = prev.xivlauncher-rb.override {
            extraExecArgs = "env SDL_VIDEODRIVER=wayland ${prev.lib.getExe prev.gamescope} -f -h 1080 -r 240 -O DP-1 --adaptive-sync --immediate-flips --force-grab-cursor --rt --ready-fd --expose-wayland --backend wayland --";
          };
          lutris = prev.lutris.override {
            extraPkgs = p: [ p.umu-launcher ];
          };
        }
      );
  };
}
