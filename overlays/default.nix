{ withSystem, ... }:
{
  flake.overlays = {
    additions = _: prev: withSystem prev.stdenv.hostPlatform.system ({ config, ... }: config.packages);
    modifications =
      _: prev:
      withSystem prev.stdenv.hostPlatform.system (_: {
        lutris = prev.lutris.override { extraPkgs = p: [ p.umu-launcher ]; };
        hyprlandPlugins.hyprsplit = prev.hyprlandPlugins.hyprsplit.overrideAttrs (old: {
          version = "0.48.0";
          src = prev.fetchFromGitHub {
            owner = "shezdy";
            repo = "hyprsplit";
            rev = "refs/tags/v0.48.0";
            hash = "";
          };
        });
      });
  };
}
