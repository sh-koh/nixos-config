{
  config
, pkgs
, lib
, theme
, inputs
, outputs
, ...
}:
{

  imports = [
    ./programs/default.nix
  ];

  home = {
    username = "shakoh";
    homeDirectory = "/home/shakoh";
  };

  xdg.dataFile = {
    wine-ge = let
      version = "GE-Proton8-14";
      name = "wine-lutris-${version}-x86_64";
    in {
      recursive = false;
      target = "lutris/runners/wine/${name}";
      source = builtins.fetchTarball {
        url = "https://github.com/GloriousEggroll/wine-ge-custom/releases/download/${version}/${name}.tar.xz";
        sha256 = "1xfxvd7wd1siwladlcxxwwrmvf14q7x2ll17r69j5dmb2pj0dcc0";
      };
    };
  };
  
  home.file = {
  };

  home.sessionVariables = {
  };

  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    zsh = {
      enable = true;
      enableCompletion = true;
      enableAutosuggestions = true;
      oh-my-zsh = {
        enable = true;
        theme = "agnoster";
        #plugins = [ ];
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

    vscode = {
      enable = true;
      package = pkgs.vscodium;
      extensions = with pkgs.vscode-extensions; [
        arrterian.nix-env-selector
        jnoortheen.nix-ide
        mkhl.direnv
        ms-vscode.cpptools
        ms-kubernetes-tools.vscode-kubernetes-tools
        ms-azuretools.vscode-docker
        rust-lang.rust-analyzer
        vscodevim.vim
      ];
    };
  };

  xdg = {
    enable = true;
    desktopEntries = {
      discord-canary = {
        name = "Discord Canary";
        icon = "discord-canary";
        exec = "discordcanary --enable-features=UseOzonePlatform --ozone-platform=wayland --no-sandbox --ignore-gpu-blocklist --enable-features=VaapiVideoDecoder --use-gl=desktop --enable-gpu-rasterization --enable-zero-copy";
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
        exec = "env NIXOS_OZONE_WL= webcord --use-gl=desktop";
      };
    };
  };

  # Reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.stateVersion = "23.05"; 
}
