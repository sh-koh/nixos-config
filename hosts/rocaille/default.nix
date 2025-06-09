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
        eni-vpn
        intel
        niri
        nix
        podman
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
