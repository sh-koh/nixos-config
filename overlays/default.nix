{ inputs, ... }:
{
  additions = final: _prev: import ../pkgs { pkgs = final; }; # This one brings our custom packages from the 'pkgs' directory

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  modifications = final: prev: {
    # example = prev.example.overrideAttrs (oldAttrs: rec { ... });
    discord-canary = prev.discord-canary.override { withOpenASAR = true; };
  };
}
