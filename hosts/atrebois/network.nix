{ pkgs
, lib
, config
, inputs
, outputs
, ...
}: {
  networking = {
    hostName = "atrebois";
    networkmanager.enable = true;
    wireless.enable = false;
    enableIPv6 = false;
  };

  networking.firewall = {
    enable = true;
    interfaces.enp34s0 = {
      allowedUDPPorts = [ 9999 ];
      allowedTCPPorts = [ 9999 ];
    };
    interfaces.ztfp6jndkb = {
      allowedUDPPorts = [ 9999 ];
      allowedTCPPorts = [ 9999 ];
    };
  };

  services = {
    zerotierone = {
      enable = true;
      joinNetworks = [ "52b337794fa1f40e" ];
    };
    printing = {
      enable = true;
      drivers = [ pkgs.epson-escpr ];
      defaultShared = true;
    };
  };
}
