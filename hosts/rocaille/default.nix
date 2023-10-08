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
    inputs.hyprland.nixosModules.default
    inputs.nur.nixosModules.nur
    inputs.stylix.nixosModules.stylix
    ./hardware-configuration.nix
  ];
  
  # Bootloader.
  boot = {
    loader.systemd-boot.enable = true;
    loader.systemd-boot.consoleMode = "max";
    loader.efi.canTouchEfiVariables = true;
    kernelParams = [ "intel_iommu=on" "iommu=pt" "tsc=reliable" "clocksource=tsc" ];
    kernelModules = [ "kvm-intel" ];
  };

  # Configuration réseau.
  networking = {
    hostName = "rocaille";
    networkmanager.enable = true;
    enableIPv6 = false;
    firewall = {
      enable = true;
      interfaces.enp34s0 = {
        allowedUDPPorts = [ 9999 ];
        allowedTCPPorts = [ 9999 ];
      };
      interfaces.ztfp6jndkb = {
        allowedUDPPorts = [ 9999 ];
        allowedTCPPorts = [ 9999 ];
      };
    };
  };

  # Heure de Paris.
  time.timeZone = "Europe/Paris";

  # Clavier US-International dans le TTY.
  console = {
    keyMap = "us-acentos";
  };

  # Locale et langue.
  i18n.defaultLocale = "fr_FR.UTF-8";
  i18n.supportedLocales = [ "fr_FR.UTF-8/UTF-8" ];
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
    LC_ALL = "fr_FR.UTF-8";
    LANG = "fr_FR.UTF-8";
    LANGUAGE = "fr_FR";
  };

  # Environment and session variables  
  environment = { 
    variables = {
      STAGING_SHARED_MEMORY = "1";
      STAGING_WRITECOPY = "1";
    };
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      EDITOR = "nvim";
      VISUAL = "codium";
      XDG_SESSION_TYPE = "wayland";
      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_DESKTOP = "Hyprland";
      QT_QPA_PLATFORM = "wayland;xcb";
      SDL_VIDEODRIVER = "wayland,x11";
      CLUTTER_BACKEND = "wayland";
      MOZ_ENABLE_WAYLAND = "1";
      MOZ_WEBRENDER = "1";
      GDK_BACKEND = "wayland";
      KITTY_ENABLE_WAYLAND = "1";
    };
  };

  # Remplacement de 'sudo' par 'opendoas' et rtkit pour pipewire en temps réel.
  security = {
    sudo.enable = false;
    polkit.enable = true;
    rtkit.enable = true;
    doas.enable = true;
    doas.extraRules = [{
      users = [ "shakoh" ];
      keepEnv = true;
      persist = true;
    }];
  };

  # Services et démons
  services = {
    getty.autologinUser = "shakoh";
    blueman.enable = true;

    xserver = {
      layout = "us";
      xkbVariant = "intl";
      libinput = {
        enable = true;
        mouse.accelProfile = "flat";
      };
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };

    openssh = {
      settings = {
        enable = true;
        permitRootLogin = "no";
        passwordAuthentication = false;
      };
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

    dbus = {
      enable = true;
      implementation = "broker";
    };
  };

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [ vaapiVdpau libvdpau-va-gl libvdpau libva ];
  };

  # Docker et libvirt
  virtualisation = {
    docker = {
      enable = true;
      enableOnBoot = false;
    };
  };

  # Configuration des programmes.
  programs = {
    dconf.enable = true;
    zsh.enable = lib.mkDefault true;
    noisetorch.enable = true;

  };
  
  # Utilisateur(s) et groupes.
  users = {
    users.shakoh = {
      shell = pkgs.zsh;
      isNormalUser = true;
      description = "Shakoh";
      extraGroups = [ "networkmanager" "wheel" "video" "audio" "input" "kvm" "docker" ];
    };
  };
  
  # Paquets installés sur le système global.
  environment.systemPackages = with pkgs; [
    coreutils
    curl
    docker-compose
    fd
    git
    git-crypt
    grim
    jq
    lm_sensors
    mate.mate-polkit
    nixd
    nixdoc
    nix-index
    num-utils
    slurp
    socat
    virt-manager
    wbg
    wget
    wl-clipboard
    xdg-user-dirs
    xdg-utils
    xorg.xrandr
  ];

  # Portails XDG pour les interactions interapplications.
  xdg = {
    sounds.enable = true;
    portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };
  };

  # Thème avec 'Stylix'.
  gtk.iconCache.enable = true;
  stylix = {
    opacity = {
      applications = 1.0;
      desktop = 1.0;
      popups = 1.0;
      terminal = 0.96;
    };
    targets = {
      gtk.enable = lib.mkBefore true;
    };
    fonts = {
      serif = config.stylix.fonts.monospace;
      sansSerif = config.stylix.fonts.monospace;
      monospace = {
        package = pkgs.jetbrains-mono;
        name = "JetBrains Mono";
      };
      emoji = {
        name = "Noto Color Emoji";
        package = pkgs.noto-fonts-emoji;
      };
      sizes = {
        applications = 10;
        desktop = 10;
        popups = 10;
        terminal = 10;
      };
    };
    polarity = "dark";
    image = pkgs.fetchurl {
      url = "https://preview.redd.it/r1cji9zj3nva1.jpg?width=5760&format=pjpg&auto=webp&s=3545dd013e63c4c67745117d7e20a41d9ea9e7ef";
      sha256 = "1GUCUtxFqgqlr3e36OSP8bP0hihwdlUzTbfPDElUZG8=";
      #url = "https://i.redd.it/2edkw6grxhg91.png";
      #sha256 = "QM9b/VCcYfVJVHsOdD9/xH14kSgyJsH76ctSb8tQJ3A=";
    };
    
    base16Scheme = let 
      blacker = "#161821";
      black = "#292d3d";
      darker = "#484b5b";
      dark = "#6b7089";
      red = "#e27878";
      red1 = "#e98989";
      green = "#b4be82";
      green1 = "#c0ca8e";
      yellow = "#e2a478";
      yellow1 = "#e9b189";
      blue = "#84a0c6";
      blue1 = "#91acd1";
      magenta = "#a093c7";
      magenta1 = "#ada0d3";
      cyan = "#89b8c2";
      cyan1 = "#95c4ce";
      white = "#9ba0b5";
      whiter = "#c6c8d1";
      light = "#d2d4de";
      lighter = "#e3e4e8";
    in
    {
      base00 = blacker; # Noir le plus noir
      base01 = black; # ---
      base02 = darker; # --
      base03 = dark; # -
      base04 = white;# +
      base05 = whiter; # ++
      base06 = light; # +++
      base07 = lighter; # Blanc le plus blanc
      base08 = red; # Rouge
      base09 = yellow1; # Orange
      base0A = yellow; # Jaune
      base0B = green; # Vert
      base0C = cyan; # Cyan
      base0D = blue; # Bleu
      base0E = magenta; # Violet
      base0F = magenta1; # Rose
    }; 
  };

  # Polices.
  fonts = {
    packages = with pkgs; [ jetbrains-mono lexend nerdfonts ];
  };
  
  # Home-manager
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    users.shakoh = import ../../hm/default.nix;
  };

  # Paramètres de nix et overlays
  nixpkgs = {
    config.allowUnfree = true;
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
    ];
  };

  nix = {
    settings = {
      trusted-users = [ "root" "@wheel" ];
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
      builders-use-substitutes = true;
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  # https://nixos.org/nixos/options.html
  system.stateVersion = "23.05";

}
