{ withSystem, ... }:
{
  flake.overlays = {
    modifications =
      _final: prev:
      withSystem prev.stdenv.hostPlatform.system (
        { ... }:
        {
          lutris = prev.lutris.override {
            extraPkgs = p: [ p.umu-launcher ];
          };
        }
      );
  };
}
