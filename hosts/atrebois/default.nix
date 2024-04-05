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

  users.defaultUserShell = pkgs.zsh;
  programs = {
    command-not-found.enable = false;
    zsh.enable = lib.mkDefault true;
    adb.enable = true;
  };

  programs.river.enable = true;

  programs.steam.enable = true;
  programs.wireshark.enable = true;

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
      start = "${pkgs.dunst}/bin/dunstify 'Gamemode activé !'";
      end = "${pkgs.dunst}/bin/dunstify 'Gamemode désactivé.'";
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

  #users.users.root.hashedPassword = "!"; # Disable root password authentication
  #users.mutableUsers = false; # Only declared users
  users.users.shakoh = {
    isNormalUser = true;
    #passwordFile = config.age.secrets.shakoh-pwd.path; # Set password with agenix
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

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
    configPackages = [ pkgs.river ];
    wlr.enable = true;
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

  nix = {
    registry = lib.mapAttrs (_: value: {flake = value;}) inputs;
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;
    settings = {
      trusted-users = [ "root" "@wheel" ];
      use-xdg-base-directories = true;
      auto-allocate-uids = true;
      auto-optimise-store = true;
      builders-use-substitutes = true;
      experimental-features = [
        "auto-allocate-uids"
        "ca-derivations"
        "cgroups"
        "dynamic-derivations"
        "fetch-closure"
        "flakes"
        "nix-command"
        "recursive-nix"
        "repl-flake"
      ];
    };
  };

  # https://nixos.org/nixos/options.html
  system.stateVersion = "23.05";
}
