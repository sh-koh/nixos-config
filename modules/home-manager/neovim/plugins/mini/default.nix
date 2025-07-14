{
  inputs,
  config,
  lib,
  ...
}:
let
  miniMods = config.programs.nixvim.plugins.mini.modules;
in
{
  programs.nixvim = {
    plugins = {
      mini = {
        enable = true;
        mockDevIcons = true;
        modules = inputs.self.lib.filesToAttrSet ./.;
      };
    };
    keymaps = [
      (lib.mkIf (miniMods.files != { }) {
        mode = "n";
        key = "<leader>f";
        action = "<cmd>lua MiniFiles.open()<CR>";
        options = {
          silent = true;
          desc = "Open MiniFiles explorer";
        };
      })
    ];
  };
}
