{ withSystem, ... }:
{
  flake.overlays = {
    additions = final: _: import ../../pkgs final.pkgs;
    modifications = final: prev:
      withSystem prev.stdenv.hostPlatform.system ({ inputs', ... }:
      {
        lutris = prev.lutris.override { extraPkgs = _: [ inputs'.umu.packages.umu ]; };
      });
  };
}
