{
  pkgs,
  config,
  inputs,
  lib,
  ...
}:
{
  imports = [ inputs.self.nixosModules.nushell ];

  users = {
    mutableUsers = false;
    users = {
      root = {
        uid = 0;
        home = "/root";
        hashedPassword = "!";
      };
      shakoh = {
        uid = 1000;
        isNormalUser = true;
        # shell = pkgs.nushell;
        hashedPasswordFile = lib.mkDefault config.vaultix.secrets.shakoh-passwd.path;
        extraGroups = [
          "adbusers"
          "audio"
          "podman"
          "gamemode"
          "input"
          "kvm"
          "libvirtd"
          "networkmanager"
          "video"
          "wheel"
          "wireshark"
        ];
        openssh.authorizedKeys.keys = lib.mapAttrsToList (
          _name: value: value
        ) inputs.self.lib.pubKeys.ssh.shakoh.${config.networking.hostName};
      };
    };
  };

  security.sudo.execWheelOnly = true;

  time.timeZone = "Europe/Paris";
  console.keyMap = "us-acentos";
}
