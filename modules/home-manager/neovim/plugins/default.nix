{ inputs, ... }:
{
  imports = inputs.self.lib.dirsToList ./.;
}
