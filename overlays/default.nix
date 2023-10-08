{ inputs, ... }:
{
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs { pkgs = final; };

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  modifications = final: prev: {
    # example = prev.example.overrideAttrs (oldAttrs: rec { ... });
    discord-canary = prev.discord-canary.override { withOpenASAR = true; };
    nerdfonts = prev.nerdfonts.override { fonts = [ "JetBrainsMono" ]; };
    godot_4_updated = prev.godot_4.overrideAttrs (oldAttrs: {
      version = "4.1.2";
      commitHash = "399c9dc393f6f84c0b4e4d4117906c70c048ecf2";
      src = prev.fetchFromGitHub {
        owner = "godotengine";
        repo = "godot";
        rev = "399c9dc393f6f84c0b4e4d4117906c70c048ecf2";
        hash = "sha256-MmGjzVgFudYpjZDKQ0zkhT0SYekaMx1v93vKa2c+oP4=";
      };
    });
  };

  stable-packages = final: _prev: {
    stable = import inputs.nixpkgs-stable {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}
