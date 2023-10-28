{ config
, pkgs
, lib
, inputs
, outputs
, ...
}: {
  imports = [
    ./gaming.nix
    ./anyrun/default.nix
    ./kitty/default.nix
    ./neovim/default.nix
    ./git/default.nix
    #./hyprland/default.nix
    ./eww/default.nix
    ./river/default.nix
  ];

  home = {
    username = "shakoh";
    homeDirectory = "/home/shakoh";
  };

  home.packages = with pkgs; [
    blender
    vesktop
    firefox
    gimp
    libreoffice
    molotov
    obs-cli
    parsec-bin
    qbittorrent
    thunderbird

    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];
    
  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      enableAutosuggestions = true;
      oh-my-zsh = {
        enable = true;
        theme = "agnoster";
      };
    };
    tmux = {
      enable = true;
      shell = "${pkgs.zsh}/bin/zsh";
      aggressiveResize = true;
      clock24 = true;
      keyMode = "vi";
      plugins = with pkgs.tmuxPlugins; [{ plugin = vim-tmux-navigator; }];
    };
    obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        obs-nvfbc
        obs-pipewire-audio-capture
        obs-vaapi
        obs-vkcapture
        obs-websocket
        wlrobs
      ];
    };
  };

  xdg = {
    enable = true;
    desktopEntries = {
      discord-canary = {
        name = "Discord Canary";
        icon = "discord-canary";
        exec = "discordcanary --enable-features=UseOzonePlatform --ozone-platform=wayland --enable-features=WebRTCPipeWireCapturer --ignore-gpu-blocklist --use-gl=desktop --enable-gpu-rasterization --enable-zero-copy";
      };
      steam = {
        name = "Steam";
        icon = "steam";
        exec = "steam -pipewire-dmabuf";
      };
      tetrio-desktop = {
        name = "Tetr.io";
        icon = "tetrio-desktop";
        exec = "env GDK_BACKEND=x11 tetrio-desktop";
      };
      molotov = {
        name = "Molotov";
        icon = "molotov";
        exec = "env GDK_BACKEND=x11 molotov --no-sandbox";
      };
      osu-lazer-bin = {
        name = "osu!";
        icon = "osu!";
        exec = "env SDL_VIDEODRIVER=x11 osu\!";
      };
    };
  };

  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    cursorTheme = {
      name = "Numix-Cursor";
      package = pkgs.numix-cursor-theme;
    };
  };

  xfconf.enable = false;

  qt = {
    enable = true;
    platformTheme = "gtk";
  };

  home.pointerCursor = {
    name = "Numix-Cursor";
    package = pkgs.numix-cursor-theme;
    x11.enable = true;
    gtk.enable = true;
    size = 16;
  };

  # Reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.stateVersion = "23.05";

}
