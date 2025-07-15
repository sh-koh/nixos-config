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
        // {
          x86_64-linux = {
            xivlauncher-rb = pkgs.callPackage ./xivlauncher-rb { };
          };
          aarch64-linux = { };
          i686-linux = { }; # FIXME
          wasm32-wasi = { }; # FIXME
        }
        .${system};
    };
}
