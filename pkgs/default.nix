{ inputs, ... }:
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
        xivlauncher-rb = pkgs.callPackage ./xivlauncher-rb { };
      };
    };
}
