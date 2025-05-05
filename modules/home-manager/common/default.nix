{
  services.ssh-agent.enable = true;
  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    compression = true;
    matchBlocks = {
      "atrebois" = {
        host = "atrebois";
        hostname = "192.168.1.201";
        port = 72;
        user = "shakoh";
        identityFile = "~/.ssh/id_atrebois";
      };
      "rocaille" = {
        host = "rocaille";
        hostname = "192.168.1.202";
        port = 72;
        user = "shakoh";
        identityFile = "~/.ssh/id_rocaille";
      };
      "cravite" = {
        host = "cravite";
        hostname = "192.168.1.210";
        port = 72;
        user = "shakoh";
        identityFile = "~/.ssh/id_cravite";
      };
    };
  };
}
