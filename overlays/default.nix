{ inputs, ... }:
let
  inherit (inputs) master unstable stable;
in
{
  additions = final: _prev: import ../pkgs final.pkgs;

  master = final: prev: {
    master = import master {
      inherit (final) system;
      config.allowUnfree = true;
    };
  };

  unstable = final: _prev: {
    unstable = import unstable {
      inherit (final) system;
      config.allowUnfree = true;
    };
  };

  stable = final: _prev: {
    stable = import stable {
      inherit (final) system;
      config.allowUnfree = true;
    };
  };

  modifications = final: prev: {
    nerdfonts = prev.nerdfonts.override { fonts = [ "Iosevka" ]; };
    iosevka-bin = prev.iosevka-bin.override { variant = "SS15"; };
    prismlauncher = prev.prismlauncher.override { withWaylandGLFW = true; };
    btop = prev.btop.override { cudaSupport = true; };
    lutris = prev.lutris.override { extraPkgs = _: [ inputs.umu.packages.${final.system}.umu ]; };
  };
}
