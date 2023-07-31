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
    inputs.hyprland.nixosModules.default
    inputs.nur.nixosModules.nur
    ./hardware-configuration.nix
  ];
  
  # Bootloader.
  boot = {
    loader.systemd-boot.enable = true;
    loader.systemd-boot.consoleMode = "auto";
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
    hostName = "B450";
    networkmanager.enable = true;
    enableIPv6 = false;
  };

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Configure console keymap
  console.keyMap = "us-acentos";

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
    libvirtd.enable = true;
    docker = {
      enable = true;
      enableNvidia = true;
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
    command-not-found.enable = false;
    dconf.enable = true;
    fish.enable = lib.mkDefault true;
    noisetorch.enable = true;
    gamescope = {
      enable = true;
      package = pkgs.gamescope;
      capSysNice = true;
    };

    hyprland = {
      enable = true;
      xwayland.enable = true;
      nvidiaPatches = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland-nvidia;
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
      shell = pkgs.fish;
      isNormalUser = true;
      description = "Shakoh";
      extraGroups = [ "networkmanager" "wheel" "video" "audio" "input" "kvm" "libvirtd" "docker" ];
    };
  };

  environment.systemPackages = with pkgs; [
    coreutils
    curl
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
    wget
    wl-clipboard
    vulkan-headers
    vulkan-validation-layers
    vulkan-extension-layer
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
  qt = {
    platformTheme = "gtk";
    style = "gtk2";
  };

  # Fonts
  fonts = {
    packages = with pkgs; [ mononoki lexend nerdfonts ];
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    users.shakoh = import ../home-manager/home.nix;
  };

  nixpkgs = {
    config.allowUnfree = true;
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      inputs.hyprland.overlays.default
      inputs.eww.overlays.default
      inputs.rust-overlay.overlays.default
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
