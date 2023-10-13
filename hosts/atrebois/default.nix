{
  config,
  pkgs,
  lib,
  inputs,
  outputs,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    inputs.nur.nixosModules.nur
    inputs.stylix.nixosModules.stylix
    ./hardware-configuration.nix
  ];

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

  # Bootloader.
  boot = {
    loader.systemd-boot.enable = true;
    loader.systemd-boot.consoleMode = "max";
    loader.efi.canTouchEfiVariables = true;
    kernelPackages = pkgs.linuxKernel.packages.linux_zen;
    kernelParams = [
      "amd_iommu=on"
      "iommu=pt"
      "mitigations=off"
      "spectre_v2=off"
    ];
    kernelModules = [
      "kvm-amd"
      "kvm"
      "vfio_pci"
      "vfio"
      "vfio_virqfd"
      "vfio_iommu_type1"
      "acpi-cpufreq"
    ];
    extraModprobeConfig = ''
      options nvidia NVreg_UsePageAttributeTable=1
      options nvidia NVreg_InitializeSystemMemoryAllocations=1
      options nvidia NVreg_EnableGpuFirmware=1
      options nvidia NVreg_EnablePCIeGen3=1
      options nvidia NVreg_EnableMSI=1
      options nvidia NVreg_RegistryDwords="PowerMizerEnable=0x1; PowerMizerLevel=0x3; PowerMizerDefault=0x3; PowerMizerDefaultAC=0x3; PerfLevelSrc=0x3333; OverrideMaxPerf=0x1"
    '';
    blacklistedKernelModules = [ "nouveau" "wacom" ];
    kernel.sysctl  = { "vm.max_map_count" = "16777216"; };
  };

  # Configuration réseau.
  networking = {
    hostName = "atrebois";
    networkmanager.enable = true;
    wireless.enable = false;
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
      GBM_BACKEND = "nvidia-drm";
      LIBVA_DRIVER_NAME = "nvidia";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      __GL_SYNC_DISPLAY_DEVICE = "DP-1";
      __GL_SYNC_TO_VBLANK = "1";
      __GL_YIELD = "USLEEP";
      __GL_GSYNC_ALLOWED = "1";
      __GL_VRR_ALLOWED = "1";
      __GL_MAXFRAMESALLOWED = "1";
      __GL_DXVK_OPTIMIZATIONS = "1";
      __GL_ALLOW_UNOFFICIAL_PROTOCOL = "1";
      __NVD_BACKEND = "direct";
      STAGING_SHARED_MEMORY = "1";
      STAGING_WRITECOPY = "1";
    };
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      EDITOR = "nvim";
      #VISUAL = "codium";
      WLR_NO_HARDWARE_CURSORS = "1";
      WLR_RENDERER = "vulkan";
      XDG_CURRENT_DESKTOP = "river";
      XDG_SESSION_DESKTOP = "river";
      XDG_SESSION_TYPE = "wayland";
      QT_QPA_PLATFORM = "wayland;xcb";
      SDL_VIDEODRIVER = "wayland,x11";
      CLUTTER_BACKEND = "wayland";
      MOZ_ENABLE_WAYLAND = "1";
      MOZ_WEBRENDER = "1";
      GDK_BACKEND = "wayland,x11";
      KITTY_ENABLE_WAYLAND = "1";
    };
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

  # Services et démons
  services = {
    fstrim.enable = true;
    dbus.enable = true;
    dbus.implementation = "broker";
    xserver = {
      videoDrivers = [ "nvidia" ];
      layout = "us";
      xkbVariant = "intl";
      libinput = {
        enable = true;
        mouse.accelProfile = "flat";
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

  # Docker et libvirt
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = { 
        swtpm.enable = true;
        ovmf.enable = true;
        ovmf.packages = [ pkgs.OVMFFull.fd ];
      };
    };
    docker = {
      enable = true;
      enableNvidia = true;
      extraOptions = "--default-runtime=nvidia";
      enableOnBoot = false;
    };
  };

  environment.etc = {
    "ovmf/edk2-x86_64-secure-code.fd" = {
      source = config.virtualisation.libvirtd.qemu.package + "/share/qemu/edk2-x86_64-secure-code.fd";
    };
  };

  # Isolation CPU pour la machine virtuelle 'Windows11' via QEMU et libvirt.
  systemd.services.libvirtd.preStart = let
    qemuHook = pkgs.writeScript "qemu-hook" ''
      #!${pkgs.stdenv.shell}

      GUEST_NAME="$1"
      OPERATION="$2"
      SUB_OPERATION="$3"

      if [ "$GUEST_NAME" == "Windows11" ]; then
        if [ "$OPERATION" == "start" ]; then
          systemctl set-property --runtime -- system.slice AllowedCPUs=0-3,8-11
          systemctl set-property --runtime -- user.slice AllowedCPUs=0-3,8-11
          systemctl set-property --runtime -- init.scope AllowedCPUs=0-3,8-11
        fi

        if [ "$OPERATION" == "stopped" ]; then
          systemctl set-property --runtime -- system.slice AllowedCPUs=0-15
          systemctl set-property --runtime -- user.slice AllowedCPUs=0-15
          systemctl set-property --runtime -- init.scope AllowedCPUs=0-15
        fi
      fi
    '';
  in ''
    mkdir -p /var/lib/libvirt/hooks
    chmod 755 /var/lib/libvirt/hooks

    # Copy hook files
    ln -sf ${qemuHook} /var/lib/libvirt/hooks/qemu
  '';

  # Configuration des programmes.
  programs = {
    dconf.enable = true;
    command-not-found.enable = false;
    zsh.enable = lib.mkDefault true;
    noisetorch.enable = true;
    adb.enable = true;
    river = {
      enable = true;
      #package = ;
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
        slurp
        swww
        wl-clipboard
        wlr-randr
      ];
    };
    wireshark = {
      enable = true;
      #package = pkgs.wireshark;
    };
    gamescope = {
      enable = true;
      capSysNice = true;
    };
    gamemode = {
      enable = true;
      enableRenice = true;
      settings = {
        general = {
          desiredgov = "performance";
          defaultgov = "ondemand";
	  reaper_freq = 5;
	  softrealtime = "on";
          renice = 5;
	  ioprio = 0;
        };
	custom = {
	  start = "${pkgs.libnotify}/bin/notify-send 'Gamemode activé !'";
	  end = "${pkgs.libnotify}/bin/notify-send 'Gamemode désactivé...'";
        };
      };
    };
  };
  
  # Utilisateur(s) et groupes.
  users = {
    users.shakoh = {
      shell = pkgs.zsh;
      isNormalUser = true;
      description = "Shakoh";
      extraGroups = [ "networkmanager" "wheel" "video" "audio" "input" "kvm" "libvirtd" "docker" "adbusers" ];
    };
  };
  
  # Paquets installés sur le système global.
  environment.systemPackages = with pkgs; [
    coreutils
    curl
    docker-compose
    ffmpeg-full
    git
    git-crypt
    grim
    jq
    libcamera
    lm_sensors
    nixd
    num-utils
    pciutils
    termshark
    virt-manager
    usbutils
    vulkan-headers
    vulkan-validation-layers
    vulkan-extension-layer
    wayland
    wayland-protocols
    wget
    xdg-user-dirs
    xdg-utils
    xorg.xrandr
  ];

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
            chooser_cmd = "${pkgs.slurp}/bin/slurp -f %o -or";
          };
        };
      };
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
    extraSpecialArgs = { inherit inputs outputs; };
    users.shakoh = import ../../hm/default.nix;
  };

  # Paramètres de nix et overlays
  nixpkgs = {
    config.allowUnfree = true;
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.stable-packages
    ];
  };

  # https://nixos.org/nixos/options.html
  system.stateVersion = "23.05";
}
