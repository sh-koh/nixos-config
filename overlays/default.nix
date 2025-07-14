{ withSystem, ... }:
{
  flake.overlays = {
    modifications =
      _final: prev:
      withSystem prev.stdenv.hostPlatform.system (
        { pkgs, ... }:
        {
          steam = prev.steam.override { extraArgs = "-pipewire -pipewire-dmabuf -system-composer"; };
          xivlauncher-rb = prev.xivlauncher-rb.override {
            extraExecArgs = "env SDL_VIDEODRIVER=wayland ${prev.lib.getExe prev.gamescope} -f -h 1080 -r 240 -o 40 --adaptive-sync --immediate-flips --force-grab-cursor --force-windows-fullscreen --rt --ready-fd --expose-wayland --backend wayland --";
          };
          lutris = prev.lutris.override {
            extraPkgs = p: [ p.umu-launcher ];
          };
          proton-ge-bin = prev.proton-ge-bin.overrideAttrs (old: rec {
            version = "GE-Proton10-9";
            src = pkgs.fetchzip {
              url = "https://github.com/GloriousEggroll/proton-ge-custom/releases/download/${version}/${version}.tar.gz";
              hash = "sha256-DJ7bRjzJehSFIyBo+oJyyWui+a3udGxc38P9Hw+xU9U=";
            };
          });
        }
      );
  };
}
