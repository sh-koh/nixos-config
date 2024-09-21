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
    #./timber-hearth #atrebois
    #./attlerock #rocaille
    #./brittle-hollow #cravite
    #./hollows-lantern #lanterne
    #./giants-deep #leviathe
    #./ash-twin #sablière rouge
    #./ember-twin #sablière noire
    #./dark-bramble #sombronce
    ./quantum-moon #lune quantique
    #./interloper #l'intrus
  ];

  _module.args = {
    inherit mkNixos;
  };
}
