{ pkgs
, config
, inputs
, lib
, theme
, ...
}: {
  imports = [ inputs.anyrun.homeManagerModules.default ];

  programs.anyrun = {
    enable = true;
    config = {
      width = { fraction = 0.3; };
      height = { fraction = 0.4; };
      x = { fraction = 0.5; };
      y = { fraction = 0.5; };
      hideIcons = false;
      ignoreExclusiveZones = false;
      layer = "overlay";
      hidePluginInfo = true;
      closeOnClick = true;
      showResultsImmediately = true;
      maxEntries = null;
      plugins = with inputs.anyrun.packages.${pkgs.system}; [
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
        font-family: Lexend;
        font-size: 100%;
        padding: 4px;
        border-radius: 3px;
      }
      
      #window {
        background-color: transparent;
      }
      
      #main {
        background-color: #${base00};
        padding: 10px;
      }
      
      #match.box {
        color: #${base01};
        border-bottom: 1px solid #${base04};
      }

      #match:selected {
        color: #${base0A};
        background-color: rgba(226,164,120,0.2); /*base0A*/
        border-bottom: 2px solid #${base0A};
      }
      
      #entry {
        margin: 10px;
        padding: 4px;
        background-color: #${base01};
      }
      
      box {
        background-color: transparent;
        padding: 8px;
      }
    '';
  };
}
