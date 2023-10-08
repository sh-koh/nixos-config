{ config
, pkgs
, lib
, inputs
, outputs
, ...
}:
{

  imports = [
    ./gaming.nix
    ./anyrun/default.nix
    ./kitty/default.nix
    ./neovim/default.nix
    ./git/default.nix
    ./hyprland/default.nix
    #./eww/iceberg.nix
  ];

  home = {
    username = "shakoh";
    homeDirectory = "/home/shakoh";
  };

  home.packages =
    let
      hyprsome = inputs.hyprsome.packages.${pkgs.system};
      eww = inputs.eww.packages.${pkgs.system};
    in
    with pkgs;
    [
      blender
      btop
      celluloid
      discord-canary
      eww.eww-wayland
      firefox
      gimp
      grc
      hyprsome.default
      imv
      lf
      libreoffice
      molotov
      obs-studio
      parsec-bin
      pcmanfm
      qbittorrent
      swww
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
      webcord = {
        name = "WebCord";
        icon = "webcord";
        exec = "env NIXOS_OZONE_WL= webcord --use-gl=desktop --no-sandbox --enable-gpu-rasterization --enable-zero-copy";
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

  qt = {
    enable = true;
    style.package = pkgs.libsForQt5.breeze-qt5;
    style.name = "breeze";
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
