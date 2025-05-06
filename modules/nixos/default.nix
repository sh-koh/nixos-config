{ self, ... }:
{
  flake.nixosModules = self.lib.mkAttrFromEachDir ./.;
}
