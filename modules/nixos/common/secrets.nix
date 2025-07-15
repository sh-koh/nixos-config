{ config, inputs, ... }:
{
  imports = [ inputs.vaultix.nixosModules.default ];
  vaultix = {
    settings = {
      hostPubkey = inputs.self.lib.pubKeys.ssh.${config.networking.hostName};
      decryptedDir = "/run/vaultix";
      decryptedDirForUser = "/run/vaultix-for-user";
      decryptedMountPoint = "/run/vaultix.d";
    };
    secrets = {
      shakoh-passwd = {
        file = inputs.self + /secrets/shakoh-passwd.age;
        mode = "0400";
        owner = "root";
        group = "root";
      };
    };
    templates = { };
    beforeUserborn = [ "shakoh-passwd" ];
  };
}
