{
  config,
  mkNixos,
  withSystem,
  ...
}:
let
  system = "x86_64-linux";
in
{
  flake.nixosConfigurations.atrebois = withSystem system (
    _:
    mkNixos system (
      with config.flake.nixosModules;
      [
        ./cfg.nix
        ./hw.nix

        bluetooth
        desktop
        docker
        eni-vpn
        gaming
        niri
        nix
        nvidia
        printing
        vfio
        {
          nix.settings = {
            cores = 4;
            max-jobs = 4;
          };
        }
      ]
    )
  );
}
