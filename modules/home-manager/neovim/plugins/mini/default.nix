{
  inputs,
  config,
  lib,
  ...
}:
let
  miniModules = config.programs.nixvim.plugins.mini.modules;
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
      (lib.mkIf (miniModules.files != { }) {
        mode = "n";
        key = "<leader>f";
        action = "<cmd>lua MiniFiles.open()<CR>";
        options = {
          silent = true;
          desc = "Open MiniFiles explorer";
        };
      })
      (lib.mkIf (miniModules.pick != { }) {
        mode = "n";
        key = "<leader><leader>";
        action = "<cmd>Pick resume<CR>";
        options = {
          silent = true;
          desc = "Resume Pick";
        };
      })
      (lib.mkIf (miniModules.pick != { }) {
        mode = "n";
        key = "<leader>tf";
        action = "<cmd>Pick files tool=rg<CR>";
        options = {
          silent = true;
          desc = "Pick files (rg)";
        };
      })
      (lib.mkIf (miniModules.pick != { }) {
        mode = "n";
        key = "<leader>tf";
        action = "<cmd>Pick files tool=fd<CR>";
        options = {
          silent = true;
          desc = "Pick files (fd)";
        };
      })
      (lib.mkIf (miniModules.pick != { }) {
        mode = "n";
        key = "<leader>tg";
        action = "<cmd>Pick grep_live tool=rg<CR>";
        options = {
          silent = true;
          desc = "Pick grep_live";
        };
      })
      (lib.mkIf (miniModules.pick != { }) {
        mode = "n";
        key = "<leader>tG";
        action = "<cmd>Pick grep tool=rg<CR>";
        options = {
          silent = true;
          desc = "Pick grep";
        };
      })
      (lib.mkIf (miniModules.pick != { }) {
        mode = "n";
        key = "<leader>tH";
        action = "<cmd>Pick help<CR>";
        options = {
          silent = true;
          desc = "Pick help";
        };
      })
      (lib.mkIf (miniModules.pick != { }) {
        mode = "n";
        key = "<leader>td";
        action = "<cmd>Pick diagnostic<CR>";
        options = {
          silent = true;
          desc = "Pick diagnostic";
        };
      })
      (lib.mkIf (miniModules.pick != { }) {
        mode = "n";
        key = "<leader>sD";
        action = "<cmd>Pick lsp scope='declaration'<CR>";
        options = {
          silent = true;
          desc = "Pick lsp declaration";
        };
      })
      (lib.mkIf (miniModules.pick != { }) {
        mode = "n";
        key = "<leader>sd";
        action = "<cmd>Pick lsp scope='definition'<CR>";
        options = {
          silent = true;
          desc = "Pick lsp definition";
        };
      })
      (lib.mkIf (miniModules.pick != { }) {
        mode = "n";
        key = "<leader>ss";
        action = "<cmd>Pick lsp scope='document_symbol'<CR>";
        options = {
          silent = true;
          desc = "Pick lsp document_symbol";
        };
      })
      (lib.mkIf (miniModules.pick != { }) {
        mode = "n";
        key = "<leader>si";
        action = "<cmd>Pick lsp scope='implementation'<CR>";
        options = {
          silent = true;
          desc = "Pick lsp implementation";
        };
      })
      (lib.mkIf (miniModules.pick != { }) {
        mode = "n";
        key = "<leader>sr";
        action = "<cmd>Pick lsp scope='references'<CR>";
        options = {
          silent = true;
          desc = "Pick lsp references";
        };
      })
      (lib.mkIf (miniModules.pick != { }) {
        mode = "n";
        key = "<leader>st";
        action = "<cmd>Pick lsp scope='type_definition'<CR>";
        options = {
          silent = true;
          desc = "Pick lsp type_definition";
        };
      })
      (lib.mkIf (miniModules.pick != { }) {
        mode = "n";
        key = "<leader>sS";
        action = "<cmd>Pick lsp scope='workspace_symbol'<CR>";
        options = {
          silent = true;
          desc = "Pick lsp workspace_symbol";
        };
      })
      (lib.mkIf (miniModules.pick != { }) {
        mode = "n";
        key = "<leader>tq";
        action = "<cmd>Pick list scope='quickfix'<CR>";
        options = {
          silent = true;
          desc = "Pick list quickfix";
        };
      })
      (lib.mkIf (miniModules.pick != { }) {
        mode = "n";
        key = "<leader>tN";
        action = "<cmd>Pick list scope='jump'<CR>";
        options = {
          silent = true;
          desc = "Pick list jump";
        };
      })
      (lib.mkIf (miniModules.pick != { }) {
        mode = "n";
        key = "<leader>tm";
        action = "<cmd>Pick marks scope='buf'<CR>";
        options = {
          silent = true;
          desc = "Pick marks buf";
        };
      })
      (lib.mkIf (miniModules.pick != { }) {
        mode = "n";
        key = "<leader>tM";
        action = "<cmd>Pick marks scope='all'<CR>";
        options = {
          silent = true;
          desc = "Pick marks all";
        };
      })
      (lib.mkIf (miniModules.pick != { }) {
        mode = "n";
        key = "<leader>tb";
        action = "<cmd>Pick buffers<CR>";
        options = {
          silent = true;
          desc = "Pick buffers";
        };
      })
      (lib.mkIf (miniModules.pick != { }) {
        mode = "n";
        key = "<leader>tr";
        action = "<cmd>Pick registers<CR>";
        options = {
          silent = true;
          desc = "Pick registers";
        };
      })
    ];
  };
}
