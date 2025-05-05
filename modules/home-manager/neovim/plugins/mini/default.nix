{ lib, ... }:
{
  programs.nixvim.plugins = {
    mini = {
      enable = true;
      mockDevIcons = true;
      modules = lib.pipe (builtins.readDir ./.) [
        (lib.filterAttrs (
          name: _type: name != "default.nix" # && name != "./ai.nix"
        ))
        (lib.mapAttrsToList (
          name: _type: {
            name = lib.removeSuffix ".nix" name;
            value = import ./${name};
          }
        ))
        builtins.listToAttrs
      ];
    };
  };
}
