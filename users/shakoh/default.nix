{
  inputs,
  config,
  withSystem,
  ...
}:
let
  mkHome =
    system: extraModules:
    withSystem system (
      {
        pkgs,
        self',
        inputs',
        ...
      }:
      inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit self' inputs' inputs; };
        modules =
          with config.flake.homeModules;
          [
            ./core.nix
            {
              nixpkgs.config = {
                allowUnfree = true;
                overlays = with config.flake.overlays; [
                  default
                  modifications
                ];
              };
            }
            common
            git
            shell
            theme
          ]
          ++ extraModules;
      }
    );
in
{
  flake.homeConfigurations = {
    "shakoh" = mkHome "x86_64-linux" [ ];
    "shakoh@atrebois" = mkHome "x86_64-linux" [ ./atrebois.nix ];
    "shakoh@rocaille" = mkHome "x86_64-linux" [ ./rocaille.nix ];
    "shakoh@cravite" = mkHome "aarch64-linux" [ ./cravite.nix ];
  };
}
