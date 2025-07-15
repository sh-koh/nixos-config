{ self, ... }:
{
  flake.vaultix = {
    # nodes = inherit ((colmena.lib.makeHive self.colmena).introspect (x: x)) nodes; # For colmena
    nodes = self.nixosConfigurations;
    identity = "/home/shakoh/.age/secrets";
    cache = "./secrets/.cache";
    defaultSecretDirectory = "./secrets";
  };
}
