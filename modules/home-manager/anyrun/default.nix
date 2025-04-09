{
  config,
  pkgs,
  inputs,
  ...
}:
let
  inherit (inputs) anyrun;
in
{
  imports = [ anyrun.homeManagerModules.default ];

  programs.anyrun = {
    enable = true;
    config = {
      width.fraction = 0.3;
      height.fraction = 0.5;
      x.fraction = 0.5;
      y.fraction = 0.5;
      hideIcons = false;
      ignoreExclusiveZones = false;
      layer = "overlay";
      hidePluginInfo = true;
      closeOnClick = true;
      showResultsImmediately = false;
      maxEntries = null;
      plugins = with anyrun.packages.${pkgs.system}; [
        applications
        dictionary
        rink
        shell
        translate
      ];
    };
    extraCss = with config.lib.stylix.colors; ''
      * {
        all: unset;
        font-family: ${config.stylix.fonts.serif.name};
        font-size: 100%;
        padding: 4px;
        border-radius: 3px;
        transition: 125ms;
      }

      #main {
        background-color: #${base00};
        padding: 10px;
      }

      list#main {
        padding: 0px;
        margin: 0px;
      }

      #match {
        color: #${base04};
      }

      #match:selected {
        color: #${base06};
        background-color: alpha(#${base08}, 0.3);
        border: 1px solid alpha(#${base08}, 0.5);
        padding: 10px 0;
      }

      #entry {
        font-weight: bold;
        font-size: 110%;
        margin: 2px;
        padding: 10px;
        color: #${base01};
        background-color: #${base08};
      }

      box {
        background-color: transparent;
        padding: 0px;
      }
    '';
  };
}
