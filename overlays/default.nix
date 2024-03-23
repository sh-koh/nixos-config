{ inputs, ... }: {
  additions = final: _prev: import ../pkgs { pkgs = final; };

  modifications = final: prev: {
    nerdfonts = prev.nerdfonts.override { fonts = [ "JetBrainsMono" ]; };
    wlroots-nvidia = prev.wlroots_0_17.overrideAttrs (oldAttrs: { patches = ./patches/wlroots-nvidia.patch; });
    prismlauncher = prev.prismlauncher.override { withWaylandGLFW = true; };
  };

  master-packages = final: _prev: {
    master = import inputs.nixpkgs-master {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}
