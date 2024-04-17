{ inputs, ... }: {
  additions = final: _prev: import ../pkgs { pkgs = final; };

  modifications = final: prev: {
    nerdfonts = prev.nerdfonts.override { fonts = [ "JetBrainsMono" ]; };
    wlroots = prev.wlroots_0_17.overrideAttrs (oldAttrs: { patches = ./patches/wlroots-nvidia.patch; });
    prismlauncher = prev.prismlauncher.override { withWaylandGLFW = true; };
    vesktop = prev.vesktop.overrideAttrs (oldAttrs: {
      src = final.fetchFromGitHub {
        owner = "kaitlynkittyy";
        repo = "Vesktop";
        rev = "11f9970f0ce22798b6c53f88565de8bb044798c8";
        hash = "sha256-+jxJQNwqYmgjUXGSW3CqP+XIdYlgXBKAyrevQSttFvc=";
      };
    });
  };

  master = final: _prev: {
    master = import inputs.nixpkgs-master {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}
