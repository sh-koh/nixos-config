{
  inputs,
  config,
  withSystem,
  ...
}:
let
  inherit (config.flake) homeManagerModules;
  mkHome = system: extraModules:
    withSystem system ({ pkgs, self', inputs', ... }:
      inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit self' inputs' inputs; };
        modules = [
          ./core.nix

          homeManagerModules.common
          homeManagerModules.git
          homeManagerModules.neovim
          homeManagerModules.shell
          homeManagerModules.theme
        ] ++ extraModules;
      }
    );
in
{
  flake.homeConfigurations = {
    "shakoh" = mkHome "x86_64-linux" [];
    "shakoh@atrebois" = mkHome "x86_64-linux" [ ./atrebois.nix ];
    "shakoh@rocaille" = mkHome "x86_64-linux" [ ./rocaille.nix ];
    "shakoh@cravite" = mkHome "aarch64-linux" [ ./cravite.nix ];
  };
}
