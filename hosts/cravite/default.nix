{
  config,
  pkgs,
  lib,
  inputs,
  outputs,
  ...
}:
{

  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./virt.nix
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = false;

  networking = {
    hostName = "cravite";
    wireless.enable = false;
    networkmanager.enable = true;
  };

  # Configuration OpenSSH
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
  };

  environment.systemPackages = with pkgs; [
    coreutils
    curl
    git
    lm_sensors
    pciutils
    psmisc
    usbutils
    wget
  ];

  users.users.shakoh = {
    isNormalUser = true;
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCgByiZNkEDYHzVbOlaKJSweJ2uPjuRacQDfTXO5Dwcaq0rRQXjzkarC3YpBo8mqeam09CnSQBM5XFXlt4GFr8fScw0MSfcPEvj16ybgI/b2opg8a3OPGQ29rz9setUBmKYPRD94K7khwqu/tp39+2tvEI8J4HeBGXV1tmyCjrdFWXfbPdJwmi32cAlwAEcUDHrlXUXU4Kk0kbnN13VUx+rL6o/+MCeAb2NDJuo8mfMzWM2Z/DiKvz4qFnUDW43gDC4YqNMIAFuaFcCudvpJwYlTkHz46V6ErQ16ZB7S++qgL+0wn/pER7vvmtH7E4sPjN1gZsKskZoOy3WdcXXGXxpu46AmbLBvGnnp6V3x/n5/OZAtP0AgD4yM6gZnNF5G5kUoEu0b1txqYUhLBLvoLyOZtVjMUE5kq3o2rlnLYSapKO36Zfexm8q1IYs6APC5bTlt8Eo7rSaFwA8LrMrQbdXFbIrvm67fVoPeQgdS2DJ4QVX98exf/kVeoZszMeg2/irpSodSvqcfdlnALtzvxIXZO9lYgfQOyZelmHuh5HzrzUWUlI2goMbyJ+JYf8BH+DVVSXS1UwQysBi5lRGETsX0q/8wsjDrkKsPERd9ue7E7fkdoUCMUbA29G0aswEuR4dh7C+qOktJ4z2mVr2ew8CEGesIARnW7RZvJNg53pX9Q== shakoh@atrebois"
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDcsKJPBMqyHS2TmYBFFyP+jGGFnOXnNY7/JWUwD1mWS3p6gMxtXTHZAAXLq/g2SG3gHUSpCWcytC9x5IFmYpf/9BCVZHwuUf8gSSQSAycTDoGWeY0AQ1KEOIUAQ1wWlG3iLFlaI48ugBR3m+gv2YlpY9FU47uj3bgIn6KF1fZCPFetQtIPE1TaKOYgd6M27deOo2pNxGQiGkvAkogfb7tqRjQQ5aWmtk4Uc32N8Frhce5QUWuI8AOqf4MfPXVOq6EyK0TLYPE+WEBSbf6kumme+BCwZ2SFN++yFJzVqGJQReRJJFXEf5vSRXN/60Rue0eF/GCbR838TiF+nDjge7W9jhABvUc0wNwlwHtSYoOVqxNuhwukaEcYhCnoiaerbwulPg4DJnD9eaBuH39b9+pEDp9b2AIB6jUaAU+zQ6GyGDVbJrcf+jVAMEn2ZqXRfLyRjNiof+0mivMgJ/vR1MxtcBD0NRV3n49CkvQNG4jrB6M738OzsudP0nkkwfyVHI4ZcAgwOqvY2KUEDnLyHvVOnr45zKvbbiKwfkAFRQevFgjClUJYJutfyo8bfZNxOyrVp0hCstgJ2lBqzAP2G65sO/VkLCqVLU/rV5ZoXt2sRCEnq5m2WtflL3nMcwDSUyl+HLqsd/T1AooOFJHLOd9bBaLOrsucogrj/Y+UkKIlYw== shakoh@rocaille"
    ];
    extraGroups = [
      "wheel"
      "kvm"
      "libvirtd"
      "qemu-libvirtd"
      "docker"
    ];
  };

  # Home-manager
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      inherit inputs outputs;
    };
    users.shakoh = import ../../home/profiles/cravite.nix;
  };

  security.sudo.execWheelOnly = true;

  powerManagement.cpuFreqGovernor = "ondemand";

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

  nix =
    let
      flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
    in
    {
      package = pkgs.nixVersions.nix_2_23;
      registry = lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs;
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
  system.stateVersion = "23.11";
}
