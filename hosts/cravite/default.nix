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
  flake.nixosConfigurations.cravite = withSystem system (
    _:
    mkNixos system (
      with config.flake.nixosModules;
      [
        ./cfg.nix
        ./hw.nix

        bluetooth
        common
        nix
        podman
        {
          nix.settings = {
            cores = 2;
            max-jobs = 2;
          };
        }
      ]
    )
  );
}
