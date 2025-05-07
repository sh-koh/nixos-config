{ config, pkgs, lib, ... }:
let
  cfg = config.programs.nushell;
in
{
  options = {
    programs.nushell = {
      enable = lib.mkEnableOption {
        default = false;
        type = lib.types.bool;
      };

      package = lib.mkPackageOption pkgs "nushell" {};

      shellAliases= lib.mkOption {
        default = { };
        type = with lib.types; attrsOf (nullOr (either str path));
      };
    };
  };

    config = lib.mkIf cfg.enable {
      programs.nushell.shellAliases = lib.mapAttrs (name: lib.mkDefault) config.environment.shellAliases;

      environment = {
        systemPackages = [ cfg.package ];
        pathsToLink = [ "/share/nushell/vendor" ];
        shells = [
          "/run/current-system/sw/bin/nu"
          (lib.getExe cfg.package)
        ];
      };
    };
}
