{ inputs, ... }: {
  additions = final: _prev: import ../pkgs { pkgs = final; };

  modifications = final: prev: {
    nerdfonts = prev.nerdfonts.override { fonts = [ "JetBrainsMono" ]; };
    prismlauncher = prev.prismlauncher.override { withWaylandGLFW = true; };
  };

  master = final: _prev: {
    master = import inputs.nixpkgs-master {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}
