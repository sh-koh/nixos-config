{
  inputs,
  config,
  lib,
  ...
}:
{
  services.ssh-agent.enable = true;
  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    compression = true;
    hashKnownHosts = true;
    matchBlocks =
      lib.concatMapAttrs
        (host: lastByte: {
          ${host} = {
            inherit host;
            hostname = "192.168.1.${builtins.toString lastByte}";
            port = 72;
            user = "shakoh";
            identityFile = "~/.ssh/id_${host}";
            forwardAgent = true;
            compression = true;
            serverAliveInterval = 0;
            serverAliveCountMax = 3;
          };
        })
        (
          builtins.removeAttrs {
            atrebois = 201;
            rocaille = 202;
            cravite = 210;
          } [ config.home.sessionVariables.HOSTNAME ]
        );
  };
}
