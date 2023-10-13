{
  default, pkgs, config, inputs, lib, theme, ...
}:
{

  imports = [
    inputs.anyrun.homeManagerModules.default
  ];

  programs.anyrun = {
    enable = true;
    config = {
      width = {absolute = 656; };
      height = { absolute = 350; };
      x = { fraction = 0.5; };
      y = { fraction = 0.5; };
      hideIcons = false;
      ignoreExclusiveZones = false;
      layer = "overlay";
      hidePluginInfo = false;
      closeOnClick = false;
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
          transition: 200ms ease-in;
          font-size: 100%;
          padding: 2px;
          border-radius: 3px;
        }

        #window {
          background: transparent;
        }

        #plugin,
        #main {
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
        }

        box#main {
          background-color: ${base02};
          padding: 8px;
        }
    '';
  };

}
