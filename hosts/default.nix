{
  config,
  inputs,
  withSystem,
  ...
}:
let
  mkSystem =
    system: extraModules:
    inputs.nixpkgs.lib.nixosSystem {
      specialArgs = withSystem system (
        { inputs', self', ... }:
        {
          inherit self' inputs' inputs;
        }
      );
      modules =
        with config.flake.nixosModules;
        [
          {
            nixpkgs = {
              hostPlatform = system;
              config.allowUnfree = true;
              overlays = with config.flake.overlays; [
                default
                modifications
              ];
            };
          }
          common
          nushell
          theme
        ]
        ++ extraModules;
    };
in
{
  imports = [
    ./atrebois
    ./rocaille
    ./cravite
    #./lanterne
    #./leviathe
    #./sabliere-rouge
    #./sabliere-noire
    #./sombronce
    #./lune-quantique
  ];

  _module.args = {
    inherit mkSystem;
  };
}
