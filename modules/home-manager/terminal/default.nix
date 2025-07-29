{ inputs, ... }:
{
  imports = inputs.self.lib.listAllFiles ./.;
}
