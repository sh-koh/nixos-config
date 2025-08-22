{
  config,
  mkSystem,
  withSystem,
  ...
}:
let
  system = "aarch64-linux";
in
{
  flake.nixosConfigurations.cravite = withSystem system (
    _:
    mkSystem system (
      with config.flake.nixosModules;
      [
        ./cfg.nix
        ./hw.nix

        bluetooth
        common
        nix
        podman
        {
          nix.settings.max-jobs = 2;
          time.timeZone = "Europe/Paris";
          console.keyMap = "us-acentos";
        }
      ]
    )
  );
}
