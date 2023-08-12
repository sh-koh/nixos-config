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
    kernelPackages = pkgs.linuxKernel.packages.linux_xanmod_latest;
    kernelParams = [ "amd_iommu=on" "iommu=pt" "mitigations=off" "tsc=reliable" "clocksource=tsc" "spectre_v2=off" "pcie_aspm.policy=performance" ];
    kernelModules = [ "kvm-amd" "kvm" "vfio_pci" "vfio" "vfio_virqfd" "vfio_iommu_type1" "acpi-cpufreq" ];
    extraModprobeConfig = ''
      options nvidia NVreg_UsePageAttributeTable=1
      options nvidia NVreg_InitializeSystemMemoryAllocations=1
      options nvidia NVreg_EnableGpuFirmware=1
      options nvidia NVreg_OpenRmEnableUnsupportedGpus=1
      options nvidia NVreg_RegistryDwords="PowerMizerEnable=0x1; PowerMizerLevel=0x3; PowerMizerDefault=0x3; PowerMizerDefaultAC=0x3; PerfLevelSrc=0x3333; OverrideMaxPerf=0x1"
    '';
    blacklistedKernelModules = [ "nouveau" "wacom" ];
    kernel.sysctl  = { "vm.max_map_count" = "16777216"; };
  };

  networking = {
    hostName = "atrebois";
    networkmanager.enable = true;
    enableIPv6 = false;
  };

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Configure console
  console = {
    keyMap = "us-acentos";
  };

  # Select internationalisation properties.
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
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "${inputs.nix-gaming.packages.${pkgs.system}.proton-ge}";
      GBM_BACKEND = "nvidia-drm";
      LIBVA_DRIVER_NAME = "nvidia";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      __GL_SYNC_DISPLAY_DEVICE = "DP-3";
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
      VISUAL = "codium";
      XDG_SESSION_TYPE = "wayland";
      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_DESKTOP = "Hyprland";
      QT_QPA_PLATFORM = "wayland;xcb";
      SDL_VIDEODRIVER = "wayland,x11";
      WLR_NO_HARDWARE_CURSORS = "1";
      WLR_RENDERER = "vulkan";
      CLUTTER_BACKEND = "wayland";
      MOZ_ENABLE_WAYLAND = "1";
      MOZ_WEBRENDER = "1";
      GDK_BACKEND = "wayland";
      KITTY_ENABLE_WAYLAND = "1";
    };
  };

  # Configure doas 
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

  # System services and daemon
  services = {
    getty.autologinUser = "shakoh";
    fstrim.enable = true;

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

  # Docker and libvirt
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
      enableOnBoot = false;
    };
  };

  environment.etc = {
    "ovmf/edk2-x86_64-secure-code.fd" = {
      source = config.virtualisation.libvirtd.qemu.package + "/share/qemu/edk2-x86_64-secure-code.fd";
    };
  };

  # Libvirtd cpu cores isolation for better performance in VMs
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

  # Programs properties
  programs = {
    dconf.enable = true;
    zsh.enable = lib.mkDefault true;
    noisetorch.enable = true;
    gamescope = {
      enable = true;
      package = pkgs.gamescope;
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

  users = {
    users.shakoh = {
      shell = pkgs.zsh;
      isNormalUser = true;
      description = "Shakoh";
      extraGroups = [ "networkmanager" "wheel" "video" "audio" "input" "kvm" "libvirtd" "docker" ];
    };
  };

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
    vulkan-headers
    vulkan-validation-layers
    vulkan-extension-layer
    wbg
    wget
    wl-clipboard
    xdg-user-dirs
    xdg-utils
    xorg.xrandr
  ];

  # XDG utilities
  xdg = {
    sounds.enable = true;
    portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };
  };

  # Theming 
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

  # Fonts
  fonts = {
    packages = with pkgs; [ jetbrains-mono lexend nerdfonts ];
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    users.shakoh = import ../../hm/default.nix;
  };

  nixpkgs = {
    config.allowUnfree = true;
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
    ];
  };
      
  nix = {
    registry = lib.mapAttrs (_: value: {flake = value;}) inputs; # Add each inputs as a nix registry
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry; # For legacy commands
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
