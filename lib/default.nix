{ lib, ... }:
{
  flake.lib = {
    /**
      List all directories from a given path and generate
      a list of it, useful when you want to load every
      directory of a location.

      # Input
      `path`: The path that contains the list of directories
      you want to make a list of.

      # Type
      dirsToList :: Path -> [Path]

      # Exemple
      dirsToList ../modules
      => [ ../modules/nixos ../modules/home-manager ]
    */
    dirsToList =
      path:
      lib.pipe (builtins.readDir path) [
        (lib.filterAttrs (_name: type: type == "directory"))
        (lib.mapAttrsToList (name: _value: path + ("/" + name)))
      ];

    /**
      List all files from a given path and generate an attrset
      from it, with the name being the file name without the
      file extension and the value is its import.

      # Input
      `path`: The path that contains the list of files you want
      to import with their names as an attrset.

      # Type
      filesToAttrSet :: Path -> AttrSet

      # Exemple
      filesToAttrSet ../home-manager/neovim/plugins/mini
      => { ai = import ../home-manager/neovim/plugins/mini/ai.nix; align = import ../home-manager/neovim/plugins/mini/align.nix; ... }
    */
    filesToAttrSet =
      path:
      lib.pipe (builtins.readDir path) [
        (lib.filterAttrs (name: _type: name != "default.nix"))
        (lib.mapAttrsToList (
          name: _value: {
            name = lib.removeSuffix ".nix" name;
            value = import (path + ("/" + name));
          }
        ))
        builtins.listToAttrs
      ];

    /**
      List all directories from a given path and generate
      an attrset containing an attr for each directory,
      containing the path to the folder as a value.
      Useful when you want to make individual
      nixos/home-manager modules from a list of folders.

      # Input
      `path`: the path that contains the list of directories
      you want to make attrs of.

      # Type
      mkAttrFromEachDir :: Path -> AttrSet

      # Exemple
      mkAttrFromEachDir ../modules/home-manager
      => { ags = ../modules/home-manager/ags; anyrun = ../modules/home-manager/anyrun; ... }
    */
    mkAttrFromEachDir =
      path:
      lib.pipe (builtins.readDir path) [
        (lib.filterAttrs (_name: type: type == "directory"))
        (lib.mapAttrsToList (
          name: _value: {
            inherit name;
            value = path + ("/" + name);
          }
        ))
        builtins.listToAttrs
      ];

    /**
      List all files in a given path and generate a list
      containing the path of each *file* without "default.nix"
      if there is one.

      # Input
      `path`: the path that contains the files you want to
      make a list of.

      # Type
      listAllFiles :: Path -> [Path]

      # Exemple
      listAllFiles ../hosts/atrebois
      => [ ../hosts/atrebois/cfg.nix ../hosts/atrebois/hw.nix ]
    */
    listAllFiles =
      path:
      lib.pipe (builtins.readDir path) [
        (lib.filterAttrs (name: type: name != "default.nix" && type == "regular"))
        (lib.mapAttrsToList (name: _value: path + ("/" + name)))
      ];

    # FIXME: need to be moved somewhere else
    pubKeys = import ./keys.nix;
  };
}
