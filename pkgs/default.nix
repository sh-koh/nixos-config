{ inputs, withSystem, ... }:
{
  perSystem =
    { pkgs, system, ... }:
    {
      _module.args.pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      packages = {
        breezex-cursor = pkgs.callPackage ./breezex-cursor { };
      };
    };

  flake.packages.x86_64-linux.xivlauncher-rb = withSystem "x86_64-linux" (
    { pkgs, ... }: pkgs.callPackage ./xivlauncher-rb { }
  );
}
