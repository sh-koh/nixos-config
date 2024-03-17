{ inputs, ... }: {
  additions = final: _prev: import ../pkgs { pkgs = final; };

  modifications = final: prev: {
    nerdfonts = prev.nerdfonts.override { fonts = [ "JetBrainsMono" ]; };
    glfw = prev.glfw.override { waylandSupport = true; };
    wlroots-nvidia = prev.wlroots_0_17.overrideAttrs (oldAttrs: { patches = ./patches/wlroots-nvidia.patch; });
    ags = prev.ags.override { extraPackages = [ inputs.nixpkgs.legacyPackages.${final.system}.sassc ]; };
  };

  master-packages = final: _prev: {
    master = import inputs.nixpkgs-master {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}
