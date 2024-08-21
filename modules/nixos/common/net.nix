{ lib, pkgs, ... }:
{
  networking = {
    networkmanager.enable = true;
    wireless.enable = false;
    enableIPv6 = false;
    useDHCP = lib.mkDefault true;
  };

  services.zerotierone = {
    enable = true;
    package = pkgs.zerotierone;
    joinNetworks = [ "52b337794fa1f40e" ];
  };
}
