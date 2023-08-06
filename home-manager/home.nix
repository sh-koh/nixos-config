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
    inputs.nixvim.homeManagerModules.nixvim
    inputs.stylix.homeManagerModules.stylix
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
      wine-staging
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
    #(pkgs.nerdfonts.override { fonts = [ "JetBrainsMono-Regular" ]; })

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
  
  stylix = {
    fonts.sizes = {
      applications = 10;
      desktop = 10;
      popups = 10;
      terminal = 10;
    };
    polarity = "dark";
    image = ./bg/canyon.jpg;
    targets = { rofi.enable = false; };
    base16Scheme = "${pkgs.base16-schemes}/share/themes/onedark.yaml"; 
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

    nixvim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      plugins = {
	nvim-cmp.enable = true;
	chadtree.enable = true;
	treesitter.enable = true;
	telescope.enable = true;
	indent-blankline.enable = true;
	which-key.enable = true;
        lsp = {
          enable = true;
          servers = {
          rust-analyzer.enable = true;
          nixd.enable = true;
          rnix-lsp.enable = true;
          lua-ls.enable = true;
          html.enable = true;
          cssls.enable = true;
          gdscript.enable = true;
          bashls.enable = true;
          clangd.enable = true;
          };
        };
      };
      extraPlugins = with pkgs.vimPlugins; [
	vim-parinfer
	vim-nix
	yuck-vim
	nvchad
	nvchad-ui
	nvchad-extensions
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
        font = "JetBrainsMono 10";
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
          font = mkLiteral ''"JetBrainsMono-Regular 26"'';
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
        font_family = "JetBrainsMono-Regular";
        bold_font = "JetBrainsMono-Bold";
        italic_font = "JetBrainsMono-Italic";
        bold_italic_font = "JetBrainsMono-BoldItalic";
        font_size = 10;
        window_padding_width = 0;
        repaint_delay = 10;
        sync_to_monitor = "yes";
        confirm_os_window_close = 0;
        enable_audio_bell = 0;
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
