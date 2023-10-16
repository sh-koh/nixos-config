{ config
, pkgs
, lib
, inputs
, outputs
, ...
}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./bootloader.nix
    ./envvar.nix
    ./network.nix
    ./theme.nix
    ./virt.nix
    ./hardware-configuration.nix
  ];
 
  # Services et démons
  services = {
    dbus.enable = true;
    dbus.implementation = "broker";
    fstrim.enable = true;
    pipewire = {
      enable = true;
      audio.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };
    zerotierone = {
      enable = true;
      joinNetworks = [ "52b337794fa1f40e" ];
    };
    printing = {
      enable = true;
      drivers = [ pkgs.epson-escpr ];
      defaultShared = true;
    };
  };

  # Configuration des programmes.
  programs = {
    command-not-found.enable = false;
    zsh.enable = lib.mkDefault true;
    noisetorch.enable = true;
    adb.enable = true;
  };

  programs.river = {
    enable = true;
    extraPackages = with pkgs; [
      btop
      dunst
      grim
      imv
      jq
      lf
      mate.mate-polkit
      mpv
      ristate-git
      rivercarro
      slurp
      swww
      wl-clipboard
      wlr-randr
    ];
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
      start = "${pkgs.libnotify}/bin/notify-send 'Gamemode activé !'";
      end = "${pkgs.libnotify}/bin/notify-send 'Gamemode désactivé...'";
    };
  };

  environment.defaultPackages = with pkgs; [
    ffmpeg-full
    git
    nixd
  ];

  # Paquets installés sur le système et accessible par tout les utilisateurs.
  environment.systemPackages = with pkgs; [
    coreutils
    curl
    lm_sensors
    pciutils
    usbutils
    vulkan-headers
    vulkan-validation-layers
    vulkan-extension-layer
    wget
    xdg-utils
  ];

  # Utilisateur(s) et groupe(s).
  users = {
    users.shakoh = {
      shell = pkgs.zsh;
      isNormalUser = true;
      description = "Shakoh";
      extraGroups = [ "networkmanager" "wheel" "video" "audio" "input" "kvm" "libvirtd" "docker" "adbusers" ];
    };
  };

  # Home-manager
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs outputs; };
    users.shakoh = import ../../hm/default.nix;
  };

  # Remplacement de 'sudo' par 'opendoas'.
  security = {
    rtkit.enable = true;
    sudo.enable = false;
    polkit.enable = true;
    doas.enable = true;
    doas.extraRules = [{
      users = [ "shakoh" ];
      keepEnv = true;
      persist = true;
    }];
  };

  xdg = {
    portal = {
      enable = lib.mkForce true;
      extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
      wlr = {
        enable = true;
        settings = {
          screencast = {
            output_name = "DP-1";
            max_fps = 60;
            #exec_before = "disable_notifications.sh";
            #exec_after = "enable_notifications.sh";
            chooser_type = "simple";
            chooser_cmd = "${lib.getExe pkgs.slurp} -f %o -or";
          };
        };
      };
    };
  };

  time.timeZone = "Europe/Paris"; # Heure de Paris.
  console.keyMap = "us-acentos"; # Clavier US-International dans le TTY.

  # Paramètres de nix et overlays
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
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
      builders-use-substitutes = true;
    };
  };

  # https://nixos.org/nixos/options.html
  system.stateVersion = "23.05";
}
