{ withSystem, ... }:
{
  flake.overlays = {
    modifications =
      final: prev:
      withSystem prev.stdenv.hostPlatform.system (
        { self, ... }:
        {
          coreutils-full = prev.lib.hiPrio prev.uutils-coreutils-noprefix;
          # diffutils = prev.lib.hiPrio prev.uutils-diffutils;
          # findutils = prev.lib.hiPrio prev.uutils-findutils;
          zoxide = prev.zoxide.override { withFzf = false; };
          steam = prev.steam.override { extraArgs = "-pipewire -pipewire-dmabuf -system-composer"; };
          xivlauncher-rb = prev.xivlauncher-rb.override {
            extraExecArgs = "${prev.lib.getExe final.gamescope}";
          };
          lutris = prev.lutris.override {
            extraPkgs = p: [ p.umu-launcher ];
          };
          proton-ge-bin = prev.proton-ge-bin.overrideAttrs (old: rec {
            version = "GE-Proton10-12";
            src = prev.fetchzip {
              url = "https://github.com/GloriousEggroll/proton-ge-custom/releases/download/${version}/${version}.tar.gz";
              hash = "sha256-mjqcN/gTfAlPDXgJUm8qxH+jvNN8iiIuF33hSQ5Y/Vo=";
            };
          });
        }
      );
  };
}
