_:
{
  perSystem = {
    pkgs,
    ...
  }:
  {
    packages = {
      hyprXPrimary = pkgs.callPackage ./hyprXPrimary { };
      hyprsplit = pkgs.callPackage ./hyprsplit { };
    };
  };
}
