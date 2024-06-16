{ config
, pkgs
, lib
, inputs
, outputs
, ...
}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ../../secrets
    ./bootloader.nix
    ./envvar.nix
    ./network.nix
    ./virt.nix
    ./hardware-configuration.nix
  ];
 
  # Services et démons
  services = {
    dbus.enable = true;
    dbus.implementation = "broker";
    fstrim.enable = true;
    upower.enable = true;
    tlp = {
      enable = true;
    };
    auto-cpufreq = {
      enable = true;
      settings = {
        battery = {
          governor = "powersave";
          turbo = "auto";
        };
        charger = {
          governor = "performance";
          turbo = "auto";
        };
      };
    };
    pipewire = {
      enable = true;
      audio.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };
  };

  services.openssh = {
    enable = true;
    ports = [ 72 ];
    settings = {
      AllowUsers = [ "shakoh" ];
      KbdInteractiveAuthentication = false;
      PasswordAuthentication = false;
    };
  };
  
  # Configuration des programmes.
  users.defaultUserShell = pkgs.zsh;
  programs = {
    command-not-found.enable = false;
    zsh.enable = lib.mkDefault true;
    adb.enable = true;
  };

  programs.hyprland = { enable = true; };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
    config = {
      hyprland.default = [ "hypland" "gtk" ];
    };
  };

  # Paquets installés sur le système et accessible par tout les utilisateurs.
  environment.systemPackages = with pkgs; [
    coreutils
    curl
    lm_sensors
    pciutils
    psmisc
    usbutils
    wget
  ];

  # Utilisateur(s) et groupe(s).
  users.users.shakoh = {
    isNormalUser = true;
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCKyCKwY3T5CgTqKNBdcy2DfSjq4WA6A42HyQsJ5LJgqxtJxPMI1ub7jM3Y8/8k/dQ7O0NG1h3YILBUp4a5ZM66JRHzDkd6kx3pTedDG6zE3+LmfjmONC1CgLa6uzlHw8H09PDQvlVvFxN2rTW65uQWcR8SnJPhFgmp0/gCGvUA2Rf0/38Pp6OMVsMnsmJDt9P2Ii4S8H6RBlmAX0OSXra4kN4k8gG5ylwMLsBdorDBJ1zPuLyBnwWksVGh3bGs7rFWkZ5nyOj7yt1/VWpGaUEL6Qz+U027EaCkfoZcdiYihlJ5ZgFXEk9SqNbmAHKt79Jbh0k48Kl6hdvWBdgGZ2hr5jlgSJT2i7YpbUPAmN0sIEY4nq7EFS+38JxmzGTaO1T71K0xfCutf2GLMvpSTjN1P3LHWlmVraVKVgMCCZ7jnYwy/VSJyVwE09Aji4ukP8JE+LRNjzGmIz7YE7Ul3zUAvFJK8Lr7f4ArBf/TPzGsrdhM5OfDADVBl27CPs7kkgZNn//z9tUAHhU8B5qNUS2QOV06y8ncCZnIdvuMXD4Lh4WlPrFdHYzuq3CgDwfPSKnZCtQZPnJwJl97kM+upZHnxBcV7/w4cBmmloB8/vgliP8umVv2bvZ9xRHsY5X063+wHIHsBQFrZ0CSixIt7rdr8A+z6AmQ+2ZiqWu3CkqWRQ== shakoh@atrebois"
    ];
    extraGroups = [
      "wheel"
      "video"
      "audio"
      "input"
      "kvm"
      "libvirtd"
      "qemu-libvirtd"
      "docker"
      "adbusers"
      "networkmanager"
    ];
  }; 

  # Home-manager
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs outputs; };
    users.shakoh = import ../../home/profiles/rocaille.nix;
  };

  security = {
    sudo.execWheelOnly = true;
    rtkit.enable = true;
    polkit.enable = true;
  };

  programs.dconf.enable = true;
  gtk.iconCache.enable = true;
  fonts.packages = with pkgs; [ jetbrains-mono lexend nerdfonts ];

  time.timeZone = "Europe/Paris";
  console.keyMap = "us-acentos";

  nixpkgs = {
    config.allowUnfree = true;
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.master
    ];
  };
  
  nix = let 
      flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    package = pkgs.nixVersions.latest;
    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
    settings = {
      flake-registry = "";
      nix-path = config.nix.nixPath;
      max-jobs = 8;
      use-cgroups = true;
      use-xdg-base-directories = true;
      auto-allocate-uids = true;
      auto-optimise-store = true;
      builders-use-substitutes = true;
      always-allow-substitutes = true;
      experimental-features = [
        "auto-allocate-uids"
        "ca-derivations"
        "cgroups"
        "configurable-impure-env"
        "daemon-trust-override"
        "dynamic-derivations"
        "fetch-closure"
        "fetch-tree"
        "flakes"
        "git-hashing"
        "impure-derivations"
        "local-overlay-store"
        "mounted-ssh-store"
        "nix-command"
        "no-url-literals"
        "parse-toml-timestamps"
        "read-only-local-store"
        "recursive-nix"
        "verified-fetches"
      ];
    };
  };

  # https://nixos.org/nixos/options.html
  system.stateVersion = "23.05";
}
