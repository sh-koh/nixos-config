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
        rev = "d0ff6192cbf81f1a0b497e16dff9ac7c23616436";
        hash = "sha256-/qd++djD5LQaDzxslAA55A6jZHCT6NLQ+RYofqn1x28=";
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
