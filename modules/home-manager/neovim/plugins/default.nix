{ lib, ... }:
{
  imports = lib.pipe (builtins.readDir ./.) [
    (lib.filterAttrs (
      _name: type: type == "directory" # && name != ${./oil}
    ))
    (lib.mapAttrsToList (name: _: ./${name}))
  ];
}
