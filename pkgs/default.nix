{ inputs, config, ... }:
{
  perSystem =
    { pkgs, system, ... }:
    {
      _module.args.pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      packages = {
        neokoh = config.flake.homeConfigurations.shakoh.config.programs.nixvim.build.package;
        breezex-cursor = pkgs.callPackage ./breezex-cursor { };
      };
    };
}
