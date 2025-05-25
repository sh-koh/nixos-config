{ inputs, ... }:
{
  perSystem =
    {
      pkgs,
      system,
      config,
      ...
    }:
    {
      _module.args.pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      overlayAttrs = config.packages;

      packages =
        {
          breezex-cursor = pkgs.callPackage ./breezex-cursor { };
        }
        // (
          if system == "x86_64-linux" then
            {
              xivlauncher-rb = pkgs.callPackage ./xivlauncher-rb { };
            }
          else if system == "aarch64-linux" then
            { }
          else
            { }
        );
    };
}
