{ pkgs, ... }:
{
  services = {
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
    printing = {
      enable = true;
      drivers = with pkgs; [
        epson-escpr
        epson-escpr2
      ];
    };
  };
}
