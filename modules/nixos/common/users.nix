{
  pkgs,
  config,
  inputs,
  lib,
  ...
}:
{
  imports = [
    inputs.self.nixosModules.secrets
    inputs.self.nixosModules.nushell
  ];

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
        hashedPasswordFile = config.age.secrets.shakoh-pwd.path;
        extraGroups = [
          "wheel"
          "video"
          "audio"
          "input"
          "kvm"
          "libvirtd"
          "docker"
          "adbusers"
          "networkmanager"
          "wireshark"
        ];
        openssh.authorizedKeys.keys = lib.mapAttrsToList (
          _name: value: value
        ) inputs.self.lib.pubKeys.ssh.shakoh.${config.networking.hostName};
      };
    };
  };

  security.sudo.execWheelOnly = true;
  #systemd.sysusers.enable = true;

  time.timeZone = "Europe/Paris";
  console.keyMap = "us-acentos";
}
