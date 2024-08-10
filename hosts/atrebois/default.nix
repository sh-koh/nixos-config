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
 
  services = {
    dbus.enable = true;
    dbus.implementation = "broker";
    fstrim.enable = true;
    upower.enable = true;
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
    startWhenNeeded = true;
    ports = [ 72 ];
    settings = {
      AllowUsers = [ "shakoh" ];
      KbdInteractiveAuthentication = false;
      PasswordAuthentication = false;
    };
  };

  hardware.opentabletdriver = {
    enable = true;
    daemon.enable = true;
  };

  programs = {
    command-not-found.enable = false;
    zsh.enable = lib.mkDefault true;
    adb.enable = true;
    wireshark.enable = true;
  };

  programs.hyprland = { enable = true; };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };

  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };

  programs.gamemode = {
    enable = true;
    enableRenice = true;
    settings.general = {
      desiredgov = "performance";
      defaultgov = "ondemand";
      reaper_freq = 5;
      softrealtime = "on";
      renice = 5;
      ioprio = 0;
    };
    settings.custom = {
      start = "${pkgs.libnotify}/bin/notify-send 'Gamemode enabled'";
      end = "${pkgs.libnotify}/bin/notify-send 'Gamemode disabled'";
    };
  };

  environment.systemPackages = with pkgs; [
    coreutils
    curl
    lm_sensors
    pciutils
    psmisc
    usbutils
    wget
  ];

  users = {
    mutableUsers = false;
    defaultUserShell = pkgs.zsh;
    users = {
      root = {
        uid = 0;
        home = "/root";
        hashedPassword = "!"; # Disable root password authentication
      };
      shakoh = {
        uid = 1000;
        isNormalUser = true;
        hashedPasswordFile = config.age.secrets.shakoh-pwd.path;
        openssh.authorizedKeys.keys = [
          "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDcsKJPBMqyHS2TmYBFFyP+jGGFnOXnNY7/JWUwD1mWS3p6gMxtXTHZAAXLq/g2SG3gHUSpCWcytC9x5IFmYpf/9BCVZHwuUf8gSSQSAycTDoGWeY0AQ1KEOIUAQ1wWlG3iLFlaI48ugBR3m+gv2YlpY9FU47uj3bgIn6KF1fZCPFetQtIPE1TaKOYgd6M27deOo2pNxGQiGkvAkogfb7tqRjQQ5aWmtk4Uc32N8Frhce5QUWuI8AOqf4MfPXVOq6EyK0TLYPE+WEBSbf6kumme+BCwZ2SFN++yFJzVqGJQReRJJFXEf5vSRXN/60Rue0eF/GCbR838TiF+nDjge7W9jhABvUc0wNwlwHtSYoOVqxNuhwukaEcYhCnoiaerbwulPg4DJnD9eaBuH39b9+pEDp9b2AIB6jUaAU+zQ6GyGDVbJrcf+jVAMEn2ZqXRfLyRjNiof+0mivMgJ/vR1MxtcBD0NRV3n49CkvQNG4jrB6M738OzsudP0nkkwfyVHI4ZcAgwOqvY2KUEDnLyHvVOnr45zKvbbiKwfkAFRQevFgjClUJYJutfyo8bfZNxOyrVp0hCstgJ2lBqzAP2G65sO/VkLCqVLU/rV5ZoXt2sRCEnq5m2WtflL3nMcwDSUyl+HLqsd/T1AooOFJHLOd9bBaLOrsucogrj/Y+UkKIlYw== shakoh@rocaille"
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
          "wireshark"
        ];
      };
    };
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs outputs; };
    users.shakoh = import ../../home/profiles/atrebois.nix;
  };

  security = {
    sudo.execWheelOnly = true;
    rtkit.enable = true;
    polkit.enable = true;
  };

  programs.dconf.enable = true;
  gtk.iconCache.enable = true;
  fonts.packages = with pkgs; [
    lexend
    nerdfonts
    iosevka-bin
  ];

  time.timeZone = "Europe/Paris";
  console.keyMap = "us-acentos";

  nixpkgs = {
    config.allowUnfree = true;
    overlays = with outputs.overlays; [
      additions
      modifications
      stable
      master
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
