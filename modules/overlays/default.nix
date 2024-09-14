{ withSystem, ... }:
{
  flake.overlays = {
    additions = final: _: import ../../pkgs final.pkgs;
    modifications = final: prev:
      withSystem prev.stdenv.hostPlatform.system ({ inputs', ... }: 
      {
        nerdfonts = prev.nerdfonts.override { fonts = [ "Iosevka" ]; };
        iosevka-bin = prev.iosevka-bin.override { variant = "SS15"; };
        btop = prev.btop.override { cudaSupport = true; };
        lutris = prev.lutris.override { extraPkgs = _: [ inputs'.umu.packages.umu ]; };
      });
  };
}
