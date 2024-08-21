{ config, inputs, withSystem, ... }:
let
  mkNixos = system: extraModules:
    let
      specialArgs = withSystem system ({ inputs', self', ... }:
        { inherit self' inputs' inputs; });
    in
    inputs.nixpkgs.lib.nixosSystem {
      inherit specialArgs;
      modules = [
        config.flake.nixosModules.common
        {
          nixpkgs.overlays = with config.flake.overlays; [
            additions
            modifications
          ];
        }
      ] ++ extraModules;
    };
in
{
  imports = [
    ./atrebois
    ./rocaille
    ./cravite
  ];

  _module.args = {
    inherit mkNixos;
  };
}
