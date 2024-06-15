{ inputs, ... }: {
  additions = final: _prev: import ../pkgs final.pkgs;

  modifications = final: prev: {
    nerdfonts = prev.nerdfonts.override { fonts = [ "JetBrainsMono" ]; };
    prismlauncher = prev.prismlauncher.override { withWaylandGLFW = true; };
    btop = prev.btop.override { cudaSupport = true; };
    lutris = prev.lutris.override { extraPkgs = pkgs: [ inputs.umu.packages.${final.system}.umu ]; };
    lutris-unwrapped = prev.lutris-unwrapped.overrideAttrs {
      version = "0.5.17";
      src = prev.fetchFromGitHub {
        owner = "lutris";
        repo = "lutris";
        rev = "v0.5.17";
        hash = "sha256-Tr5k5LU0s75+1B17oK8tlgA6SlS1SHyyLS6UBKadUmw=";
      };
      postPatch = ''
        substituteInPlace lutris/util/magic.py \
          --replace '"libmagic.so.1"' "'${prev.lib.getLib prev.file}/lib/libmagic.so.1'"
      '';
    };
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
