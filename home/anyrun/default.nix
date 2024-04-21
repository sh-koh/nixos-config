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
        border-radius: 2px;
      }
      
      #window {
        color: #${base04};
        background-color: transparent;
      }
      
      #main {
        background-color: #${base00};
        padding: 10px;
      }

      box#main { 
        border: solid 2px #${base01};
      }
      
      #match:selected {
        font-weight: bold;
        color: #${base05};
        background-color: #${base02}; /*base0A*/
      }
      
      #entry {
        font-weight: bold;
        margin: 4px;
        padding: 10px;
        color: #${base09};
        background-color: rgba(244,191,117 ,0.1);
        border-bottom: 2px solid #${base09};
      }
      
      box {
        background-color: transparent;
        padding: 8px;
      }
    '';
  };
}
