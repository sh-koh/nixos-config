{ programs.nixvim.plugins = {
    coq-thirdparty.enable = true;
    coq-nvim = {
      enable = true;
      installArtifacts = true;
      settings = {
        auto_start = true;
      };
    };
  };
}
