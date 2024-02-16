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
    pipewire = {
      enable = true;
      audio.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };
  };

  programs.ssh = {
    startAgent = true;
    knownHosts = {
      atrebois = {
        hostNames = [ "atrebois" "192.168.1.201" ];
        publicKey = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCrGo/qyLiL0EbwmnMUEAzSR69T9y7JxTNLz+ix9YsHnzqomu3aCGfBDF46i+I0sYy0Ckd6DzlBBlJHTSk4vzzt2udrUwc9WPuJEP+t2O2kwPCGZudd1p/aOJwQy9vQG7F9x5FbyTkJehdNB/6fVHpy+w3feEjgHfPCJiRlCjUTGe0beppbZxa4ucDwdE7b7WaJG4cc3vBcxRs2JrAMiZhR6IgAT2ABhnARlEDsijL+rTEoPcAHiW+WO0p0EyKe9mCh9c9jHuh7nBUvcvQnnNIyo29w5X+P5CVTd2zHYoBQK8O5lKRUnNIxBUjZZugHgE2Sm1N97+sjgzT+41LwDppbY5xIlbE5SIllPDk1T6/1yjbVIqZlvNCM26mxaESt9/pWtSFWfrYQwpyu9btvrFlIFchaxtrucb4vV+ilb7bFBj7CY1gWER7yAv6bFGeNbRtqZCrRmXvsEMA7CxUvwsfjI1IUjG+A7BsAibP5Yt39N6r30MQPUTyvS9aQ1uSQ2Kmt4Wzdr4S7l4b5CT00lI0wyzJFFfy9rZtg6mnN41SoYs6OkuGCtQTI8jGSdrMP2A9iQ7Jox9qG8UDFdWHp0a288ucLW/pGbXL4XRjbeSGVXqzaXJ4gR+wgdgOziXVj/BcuhJRkRH01lPOjlyFQp+VfIUfWERywvMMjDEb//qlQDw==";
      };
      rocaille = {
        hostNames = [ "rocaille" "192.168.1.202" ];
        publicKey = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCr9lU9rF8AMdKSca0gM9lKoRpHmrWnSa2+XdyTYekKDNPMn43s5j1qPs7f59UtOTJLd5+XB9ipWK+jYy7JsRQw1YuL62PIiUf9PUNkLcWz23E0E6fTBmKOyOjkI0RV/SYf5/V4zMq8OIO0TEhCRJg6C3eZHmDhNdue6cbZdd35Nv6qUK1ANc/ZM5UhdGCpyPnQBix84iBS6zNTFEezyKO8Bpzl7GZKzw0z+Qf9ET0nqcl/zzNUvsNvm5CIrWVv0bjE5iHRm5ik7EJa3SAvPI2fxx/jO+NbYH/cE7OR1YZ2Soy6o4OTEPLAm3hMJi9uK9Kq5KDa0u/SrGiOwfXl7ZMwDznsEu/3g/b4kN4AoFXdSKP4cHUtDRXf2XJYO1AKa3nHlqmKgJmzdQ7OEPenTCi8tyPpRoT6ZG1WrmOQgFzwu+nIyWlwPwgFKmz9uBxEAxXrqCNc22YpgPE30/j7Q6Ql8PY1BLtIln9VS3N5nSrXiMqDqtI9Fh5rEbWSKzzuhZd8vRrfj7AAfGlpiz2TajbekY2aiwNKAFSHvqLV6GVk8v/iHHM+3bJgxtC3ycIa0aPgmJWCH+U5nATqqe9r3Nx8/ieRCuCb0ac0XHarVvSE+t5Ygm8XFMcl/GyD2+9nZLHbJ4KAhB4VG7V2PcAzygkjgEvvM7QCtKWxpTBEeZkECQ==";
      };
    };
  };
  programs.ssh.extraConfig = ''
    Host atrebois
      HostName 192.168.1.201
      Port 72

    Host rocaille
      HostName 192.168.1.202
      Port 72
  '';
  services.openssh = {
    enable = true;
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

  programs.river = {
    enable = true;
    extraPackages = with pkgs; [
      btop
      grim
      imv
      jq
      lf
      mate.mate-polkit
      mpv
      river-bedload
      rivercarro
      slurp
      swww
      wl-clipboard
      wlr-randr
    ];
  };

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

  environment.defaultPackages = with pkgs; [
    ffmpeg-full
    git
    git-crypt
  ];

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
    extraGroups = [
      "wheel"
      "video"
      "audio"
      "input"
      "kvm"
      "libvirtd"
      "qemu-libvirtd"
      "podman"
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

  time.timeZone = "Europe/Paris"; # Heure de Paris.
  console.keyMap = "us-acentos"; # Clavier US-International dans le TTY.

  nixpkgs = {
    config.allowUnfree = true;
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.master-packages
    ];
  };

  nix = {
    registry = lib.mapAttrs (_: value: {flake = value;}) inputs; # Ajoute chaque inputs de la flake système dans les registres nix.
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry; # Permet l'utilisation des commandes 'legacy' avec les flakes d'actives.
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
