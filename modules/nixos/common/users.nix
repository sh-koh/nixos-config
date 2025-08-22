{
  pkgs,
  config,
  inputs,
  lib,
  ...
}:
{
  users = {
    users = {
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

  vaultix = {
    settings = {
      hostPubkey = inputs.self.lib.pubKeys.ssh.${config.networking.hostName};
      decryptedDir = "/run/vaultix";
      decryptedDirForUser = "/run/vaultix-for-user";
      decryptedMountPoint = "/run/vaultix.d";
    };
    secrets = {
      shakoh-passwd = {
        file = inputs.self + /secrets/shakoh/shakoh-passwd.age;
        mode = "0400";
        owner = "root";
        group = "root";
      };
    };
    templates = { };
    beforeUserborn = [ "shakoh-passwd" ];
  };
}
