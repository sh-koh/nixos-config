{ withSystem, ... }:
{
  flake.overlays = {
    additions = _: prev: withSystem prev.stdenv.hostPlatform.system ({ config, ... }: config.packages);
    modifications =
      _final: prev:
      withSystem prev.stdenv.hostPlatform.system (_: {
        lutris = prev.lutris.override {
          extraPkgs = p: [ p.umu-launcher ];
        };
      });
  };
}
