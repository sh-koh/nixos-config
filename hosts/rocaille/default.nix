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
  flake.nixosConfigurations.rocaille = withSystem system (
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
        intel
        niri
        nix
        printing
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
