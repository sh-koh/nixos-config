{
  config,
  pkgs,
  lib,
  theme,
  inputs,
  outputs,
  ...
}: {

  imports = [
    inputs.nix-colors.homeManagerModules.default
  ];

  home.username = "shakoh";
  home.homeDirectory = "/home/shakoh";

  home.packages =
    let

      nix-gaming = inputs.nix-gaming.packages.${pkgs.system};
      hyprsome = inputs.hyprsome.packages.${pkgs.system};

    in with pkgs; [

      # Applications
      blender
      btop
      celluloid
      cemu
      cinnamon.nemo
      citra-canary
      dex
      discord-canary
      dolphin-emu
      dunst
      eww-wayland
      firefox-wayland
      gimp
      git-credential-manager
      glfw-wayland
      godot_4
      grc
      imv
      lf
      libreoffice
      lutris
      molotov
      obs-studio
      obsidian
      parsec-bin
      prismlauncher
      qbittorrent
      vkbasalt
      vkbasalt-cli
      steam
      steam-run
      swww
      tetrio-desktop
      thunderbird-wayland
      wineWow64Packages.waylandFull
      yuzu-early-access

      # Nix gaming packages from the flake
      nix-gaming.osu-lazer-bin
      nix-gaming.proton-ge
      #nix-gaming.wine-ge

      # Hyprland things from the flakes
      hyprsome.default 

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    (pkgs.nerdfonts.override { fonts = [ "Mononoki" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment =
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/shakoh/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
  };

  gtk = {
    enable = true;
    theme = {
      name = "palenight";
      package = pkgs.palenight-theme;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    cursorTheme = {
      name = "Numix-Cursor";
      package = pkgs.numix-cursor-theme;
    };
  };

  home.pointerCursor = {
    name = "Numix-Cursor";
    package = pkgs.numix-cursor-theme;
    x11.enable = true;
    gtk.enable = true;
    size = 16;
  };

  colorScheme = {
    slug = "mountain-peek";
    name = "Mountain Peek";
    author = "https://github.com/nautilor/mountain-peek";
    colors = {
      # Black
      base00 = "#232730";
      base01 = "#1B1E25";
      # Red
      base02 = "#973d46";
      base03 = "#742f37";
      # Green
      base04 = "#7ca25c";
      base05 = "#638349";
      # Yellow
      base06 = "#e0ae4a";
      base07 = "#d19723";
      # Blue
      base08 = "#517ba5";
      base09 = "#406182";
      # Magenta
      base0A = "#94628a";
      base0B = "#744e6d";
      # Cyan
      base0C = "#5f9f9e";
      base0D = "#4d807f";
      # White
      base0E = "#d6deed";
      base0F = "#a7b5cd";
    };
  };

  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    gh.enable = true;
    git = {
      enable = true;
      userName = "Shakoh";
      userEmail = "70974710+Shakohh@users.noreply.github.com";
      package = pkgs.gitFull;
      delta.enable = true;
      lfs.enable = true;
    };

    fish = {
      enable = true;
      interactiveShellInit = ''
        direnv hook fish | source  
      '';
      plugins = [
        { name = "done"; src = pkgs.fishPlugins.done.src; }
        { name = "grc"; src = pkgs.fishPlugins.grc.src; }
        { name = "colored-man-pages"; src = pkgs.fishPlugins.colored-man-pages.src; }
        { name = "tide"; src = pkgs.fishPlugins.tide.src; }
      ];
    };

    neovim = {
      enable = lib.mkDefault true;
      viAlias = true;
      vimAlias = true;
      defaultEditor = true;
      extraPackages = [ pkgs.gcc ];
      plugins = with pkgs.vimPlugins; [
        nvchad
        nvchad-ui
        nvchad-extensions
        vim-nix
        vim-parinfer
        yuck-vim
        nvterm
        nvim-web-devicons
        gitsigns-nvim
        mason-nvim
        mason-lspconfig-nvim
        nvim-cmp
        telescope-nvim
        nvim-autopairs
        indent-blankline-nvim
        which-key-nvim
      ];
    };

    tmux = {
      enable = true;
      shell = "${pkgs.fish}/bin/fish";
      aggressiveResize = true;
      clock24 = true;
      keyMode = "vi";
      plugins = with pkgs.tmuxPlugins; [{ plugin = vim-tmux-navigator; }]; 
    };

    rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
      location = "center";
      extraConfig = {
        modi = "drun";
        display-drun = "󰍉";
        drun-display-format = "{name}";
        font = "Mononoki 10";
        show-icons = true;
        icon-theme = "Papirus-Dark";
      };
      theme = let inherit (config.lib.formats.rasi) mkLiteral;
        in {
        "*" = {
          background = mkLiteral "#232730";
          black = mkLiteral "#101216";
          grey = mkLiteral "#1B1E25";
          white = mkLiteral "#b4c0d4";
          red = mkLiteral "#973d46";
          green = mkLiteral "#7ca25c";
          yellow = mkLiteral "#e0ae4a";
          blue = mkLiteral "#517ba5";
          magenta = mkLiteral "#94628a";
          cyan = mkLiteral "#5f9f9e";

          background-color = mkLiteral "@background";
          border-radius = mkLiteral "3px";
        };

        "window" = {
          width = mkLiteral "40%";
          height = mkLiteral "51%";
          opacity = 0;
          padding = mkLiteral "6px";
          spacing = mkLiteral "6px";
          children = map mkLiteral [ "inputbar" "listview" ];
          orientation = mkLiteral "vertical";
          border = 0;
        };

        "element selected normal, element selected active, element" = {
          vertical-align = mkLiteral "0.5";
          background-color = mkLiteral "@black";
        };

        "element-text, element-icon, element-index" = {
          horizontal-align = mkLiteral "0.5";
          vertical-align = mkLiteral "0.5";
          padding = mkLiteral "11px";
          text-color = mkLiteral "@white";
          background-color = mkLiteral "rgba(0, 0, 0, 0%)";
        };

        "element normal normal, element alternate normal" = {
          horizontal-align = mkLiteral "0.5";
          vertical-align = mkLiteral "0.5";
          background-color = mkLiteral "@grey";
          text-color = mkLiteral "@white";
        };

        "inputbar" = {
          children = map mkLiteral [ "prompt" "entry" ];
          background-color = mkLiteral "@green";
          text-color = mkLiteral "@background";
          vertical-align = mkLiteral "0.5";
          horizontal-align = mkLiteral "0.5";
        };

        "prompt" = {
          padding = mkLiteral "0.3% 0.95% 0.65% 0.65%";
          margin = mkLiteral "-2px";
          vertical-align = mkLiteral "0.5";
          background-color = mkLiteral "@green";
          text-color = mkLiteral "@background";
          font = mkLiteral ''"Mononoki 26"'';
        };

        "entry" = {
          blink = true;
          padding = mkLiteral "0 0 0 1%";
          placeholder = "Rechercher des applications...";
          background-color = mkLiteral "@grey";
          placeholder-color = mkLiteral "@white";
          color = mkLiteral "@white";
          margin = mkLiteral "4px";
          vertical-align = mkLiteral "0.5";
        };

        "listview" = {
          columns = 3;
          fixed-columns = true;
          lines = 3;
          spacing = mkLiteral "5px";
          cycle = true;
          layout = mkLiteral "vertical";
          border-color = mkLiteral "@background";
        };

        "scrollbar" = {
          background-color = mkLiteral "@grey";
          handle-color = mkLiteral "@black";
          padding = mkLiteral "2px";
          handle-width = mkLiteral "5px";
        };

        "element-icon" = { size = mkLiteral "40px"; };
      };
    };

    kitty = {
      enable = true;
      shellIntegration.enableFishIntegration = true;
      settings = {
        font_family = "Mononoki";
        bold_font = "Mononoki Bold";
        italic_font = "Mononoki Italic";
        bold_italic_font = "Mononoki Italic";
        font_size = 10;

        # Black
        color0 = "#${config.colorScheme.colors.base00}";
        color8 = "#${config.colorScheme.colors.base01}";

        # Red
        color1 = "#${config.colorScheme.colors.base02}";
        color9 = "#${config.colorScheme.colors.base03}";

        # Green
        color2 = "#${config.colorScheme.colors.base04}";
        color10 = "#${config.colorScheme.colors.base05}";

        # Yellow
        color3 = "#${config.colorScheme.colors.base06}";
        color11 = "#${config.colorScheme.colors.base07}";

        # Blue
        color4 = "#${config.colorScheme.colors.base08}";
        color12 = "#${config.colorScheme.colors.base09}";

        # Magenta
        color5 = "#${config.colorScheme.colors.base0A}";
        color13 = "#${config.colorScheme.colors.base0B}";

        # Cyan
        color6 = "#${config.colorScheme.colors.base0C}";
        color14 = "#${config.colorScheme.colors.base0D}";

        # White
        color7 = "#${config.colorScheme.colors.base0E}";
        color15 = "#${config.colorScheme.colors.base0F}";

        window_padding_width = 0;

        repaint_delay = 10;
        sync_to_monitor = "yes";
        confirm_os_window_close = 0;
        enable_audio_bell = 0;

        background_opacity = "0.95";

        background = "#${config.colorScheme.colors.base00}";
        foreground = "#${config.colorScheme.colors.base0E}";

        selection_background = "#${config.colorScheme.colors.base0E}";
        selection_foreground = "#${config.colorScheme.colors.base00}";

        cursor = "#${config.colorScheme.colors.base0E}";
        cursor_text_color = "#${config.colorScheme.colors.base00}";
      };
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
        exec = "discordcanary --enable-features=UseOzonePlatform --ozone-platform=wayland";
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
        icon = "osu-lazer";
        exec = "env SDL_VIDEODRIVER=x11 osu-lazer";
      };
    };
  };

  # Reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.stateVersion = "23.05"; 
}
