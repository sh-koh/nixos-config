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
          with config.flake.homeManagerModules;
          [
            ./core.nix
            { nixpkgs.config.allowUnfree = true; }
            common
            git
            neovim
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
    "shakoh@lune-quantique" = mkHome "aarch64-linux" [ ./lune-quantique.nix ];
  };
}
