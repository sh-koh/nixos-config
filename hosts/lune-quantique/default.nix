{
  config,
  mkNixos,
  withSystem,
  ...
}:
let
  system = "aarch64-linux";
in
{
  flake.nixosConfigurations.lune-quantique = withSystem system (
    _:
    mkNixos system (
      with config.flake.nixosModules;
      [
        ./cfg.nix
        ./hw.nix

        docker
        nix
        notre-minecraft
        # {
        #   nix.settings = {
        #     cores = 4;
        #     max-jobs = 3;
        #   };
        # }
      ]
    )
  );
}
