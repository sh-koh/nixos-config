{ inputs, ... }: {
  additions = final: _prev: import ../pkgs final.pkgs;

  modifications = final: prev: {
    nerdfonts = prev.nerdfonts.override { fonts = [ "JetBrainsMono" ]; };
    prismlauncher = prev.prismlauncher.override { withWaylandGLFW = true; };
  };

  stable = final: _prev: {
    stable = import inputs.stable {
      inherit (final) system;
      config.allowUnfree = true;
    };
  };

  unstable = final: _prev: {
    unstable = import inputs.unstable {
      inherit (final) system;
      config.allowUnfree = true;
    };
  };

  master = final: _prev: {
    master = import inputs.master {
      inherit (final) system;
      config.allowUnfree = true;
    };
  };
}
