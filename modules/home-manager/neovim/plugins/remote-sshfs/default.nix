{ pkgs, ... }:
{
  programs.nixvim = {
    extraPackages = with pkgs; [ sshfs ];
    extraConfigLua = "require('remote-sshfs').setup({})";
    extraPlugins = [
      (pkgs.vimUtils.buildVimPlugin {
        name = "remote-sshfs";
        dependencies = [ pkgs.vimPlugins.telescope-nvim ];
        src = pkgs.fetchFromGitHub {
          owner = "nosduco";
          repo = "remote-sshfs.nvim";
          rev = "6e893c32ff7c5b8d0d501b748c525fa53963fb35";
          hash = "sha256-eTnVFOR7FHlkU9kwrk3q3pNo/U8OR2gJrnrMUQKGi2A=";
        };
      })
    ];
  };
}
