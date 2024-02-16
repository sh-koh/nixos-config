{ pkgs, config, lib, ... }: {
  
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    config = {
      global = {
        strict_env = true;
	#bash_path = "${lib.getExe pkgs.zsh}";
      };
    };
  };
}
