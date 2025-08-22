{
  config,
  mkSystem,
  withSystem,
  ...
}:
let
  system = "x86_64-linux";
in
{
  flake.nixosConfigurations.rocaille = withSystem system (
    _:
    mkSystem system (
      with config.flake.nixosModules;
      [
        ./cfg.nix
        ./hw.nix

        bluetooth
        desktop
        eni-vpn
        intel
        niri
        nix
        podman
        printing
        {
          nix.settings.max-jobs = 2;
          time.timeZone = "Europe/Paris";
          console.keyMap = "us-acentos";
        }
      ]
    )
  );
}
