{ self, ... }:
{
  flake.homeManagerModules = self.lib.mkAttrFromEachDir ./.;
}
