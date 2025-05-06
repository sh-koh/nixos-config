{ inputs, ... }:
{
  programs.nixvim.plugins = {
    mini = {
      enable = true;
      mockDevIcons = true;
      modules = inputs.self.lib.filesToAttrSet ./.;
    };
  };
}
