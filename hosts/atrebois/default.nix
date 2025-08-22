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
  flake.nixosConfigurations.atrebois = withSystem system (
    _:
    mkSystem system (
      with config.flake.nixosModules;
      [
        ./cfg.nix
        ./hw.nix

        bluetooth
        desktop
        eni-vpn
        gaming
        niri
        nix
        nvidia
        podman
        printing
        vfio
        {
          nix.settings.max-jobs = 8;
          time.timeZone = "Europe/Paris";
          console.keyMap = "us-acentos";
        }
      ]
    )
  );
}
