{ ... }:
{
  services.ssh-agent.enable = true;
  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    compression = true;
    matchBlocks = {
      "atrebois" = {
        hostname = "192.168.1.201";
        host = "atrebois";
        port = 72;
        user = "shakoh";
        identityFile = "~/.ssh/id_atrebois";
      };
      "rocaille" = {
        hostname = "192.168.1.202";
        host = "rocaille";
        port = 72;
        user = "shakoh";
        identityFile = "~/.ssh/id_rocaille";
      };
      "cravite" = {
        hostname = "192.168.1.253";
        host = "cravite";
        port = 72;
        user = "shakoh";
        identityFile = "~/.ssh/id_cravite";
      };
    };
  };
}
