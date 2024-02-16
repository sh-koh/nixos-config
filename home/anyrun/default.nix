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
        #window,
        #match,
        #entry,
        #plugin,
        #main {
          background: transparent;
        }

        * {
          all: unset;
          font-family: JetBrainsMono;
          font-size: 100%;
          padding: 4px;
          border-radius: 3px;
        }

        #window {
          background-color: ${base02};
          padding: 8px;
        }

        #plugin, #main {
          background-color: ${base0A};
        }

        #match:selected {
          background-color: ${base0A};
        }

        #match {
          color: ${base0B};
        }

        #entry {
          border-radius: 3px;
          margin: 20px;
        }

        box {
          background-color: ${base02};
          border: 1px solid ${base03};
          padding: 8px;
        }
    '';
  };
}
