{ self, ... }:
{
  flake.homeModules = self.lib.mkAttrFromEachDir ./.;
}
