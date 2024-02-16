{ pkgs
, lib
, config
, inputs
, outputs
, ...
}: {
  networking = {
    hostName = "rocaille";
    networkmanager.enable = true;
    wireless.enable = false;
    enableIPv6 = false;
  };

  networking.firewall = {
    enable = true;
  };

  services = {
    printing = {
      enable = true;
      drivers = [ pkgs.epson-escpr ];
    };
  };
}
