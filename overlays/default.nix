{ inputs, ... }: {
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs { pkgs = final; };

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  modifications = final: prev: {
    discord-canary = prev.discord-canary.override { withOpenASAR = true; };
    nerdfonts = prev.nerdfonts.override { fonts = [ "JetBrainsMono" ]; };
    wlroots = prev.wlroots.overrideAttrs (oldAttrs: {
      extraPatch = builtins.fetchurl {
        url = "https://raw.githubusercontent.com/hyprwm/Hyprland/main/nix/patches/wlroots-nvidia.patch";
        sha256 = "0m8pw52r0x78xmpvb867w1gpadbn4qrm1737is7mp7p6ziyd3x0x";
      };
    });
    river = prev.river.overrideAttrs (oldAttrs: {
      src = prev.fetchFromGitHub {
        owner = "riverwm";
        repo = "river";
        rev = "7f30c655c75568ae331ed0243578d91870f3f9c6";
        fetchSubmodules = true;
        hash = "sha256-7cYLP2FID/DW4A06/Ujtqp2LE7NlHwaymQLiIA8xrMk=";
      };
    });
    rivercarro = prev.rivercarro.overrideAttrs (oldAttrs: {
      version = "0.3.0-dev";
      src = prev.fetchFromSourcehut {
        owner = "~novakane";
        repo = "rivercarro";
        rev = "80765efdefea5f82578c784050c0ba89d52698c5";
        fetchSubmodules = true;
        hash = "sha256-3jKBt88cRFBypTWweFLBO7FdH3KLTGNF4wnMJWAZMco=";
      };
      nativeBuildInputs = [
        final.pkg-config final.river final.wayland final.wayland-protocols final.zig_0_10.hook
      ];
    });
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

  master-packages = final: _prev: {
    master = import inputs.nixpkgs-master {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}
