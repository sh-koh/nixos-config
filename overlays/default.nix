{ withSystem, ... }:
{
  flake.overlays = {
    modifications =
      final: prev:
      withSystem prev.stdenv.hostPlatform.system (
        { inputs', ... }:
        {
          coreutils-full = final.uutils-coreutils-noprefix;
          zoxide = prev.zoxide.override { withFzf = false; };
          steam = prev.steam.override { extraArgs = "-pipewire -pipewire-dmabuf -system-composer"; };
          xivlauncher-rb = prev.xivlauncher-rb.override {
            extraExecArgs = "${prev.lib.getExe prev.gamescope} -f -h 1080 -r 240 -o 40 --adaptive-sync --immediate-flips --force-grab-cursor --force-windows-fullscreen --rt --ready-fd --expose-wayland --backend wayland --";
          };
          lutris = prev.lutris.override {
            extraPkgs = p: [ p.umu-launcher ];
          };
          proton-ge-bin = prev.proton-ge-bin.overrideAttrs (old: rec {
            version = "GE-Proton10-10";
            src = prev.fetchzip {
              url = "https://github.com/GloriousEggroll/proton-ge-custom/releases/download/${version}/${version}.tar.gz";
              hash = "sha256-TJbeyJA9feyaBIYt5hwVUAAdev0SnoIqvhV7groxcu4=";
            };
          });
          proton-xiv-bin =
            (prev.proton-ge-bin.override { steamDisplayName = "XIV-Proton"; }).overrideAttrs
              (old: rec {
                pname = "proton-xiv-bin";
                version = "XIV-Proton10-8";
                src = prev.fetchzip {
                  url = "https://github.com/rankynbass/proton-xiv/releases/download/${version}/${version}-ntsync.tar.xz";
                  hash = "sha256-FH273YtmgDO3dtGToJ3+kzSi2/Gt6mYtrx1Mm4y1iYs=";
                };
              });
        }
      );
  };
}
