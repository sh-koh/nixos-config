{
  pkgs,
  config,
  inputs',
  ...
}:
{
  environment = {
    variables = {
      STAGING_SHARED_MEMORY = "1";
      STAGING_WRITECOPY = "1";
    };
    systemPackages = with pkgs; [
      cemu
      dolphin-emu
      heroic
      lutris
      prismlauncher
      ryujinx
      (inputs'.xivlauncher-rb.packages.xivlauncher-rb.override {
        useGameMode = true;
        nvngxPath = "${config.hardware.nvidia.package}/lib/nvidia/wine";
      })
    ];
  };

  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      extraCompatPackages = with pkgs; [ proton-ge-bin ];
    };

    gamescope = {
      enable = true;
      capSysNice = true;
    };

    gamemode = {
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
        start = "${pkgs.libnotify}/bin/notify-send 'Gamemode enabled'";
        end = "${pkgs.libnotify}/bin/notify-send 'Gamemode disabled'";
      };
    };
  };

  hardware.opentabletdriver = {
    enable = true;
    daemon.enable = true;
  };
}
