{ inputs, ... }: {
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs { pkgs = final; };

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  modifications = final: prev: {
    discord-canary = prev.discord-canary.override { withOpenASAR = true; };
    nerdfonts = prev.nerdfonts.override { fonts = [ "JetBrainsMono" ]; };
    glfw = prev.glfw.override { waylandSupport = true; };
    wlroots-nvidia = prev.wlroots_0_16.overrideAttrs (oldAttrs: { patches = ./patches/wlroots-nvidia.patch; });
    ags = prev.ags.override { extraPackages = [ inputs.nixpkgs.legacyPackages.${final.system}.sassc ]; };
 };

  master-packages = final: _prev: {
    master = import inputs.nixpkgs-master {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}
