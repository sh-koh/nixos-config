{ pkgs, ... }:
{
  environment = {
    variables = {
      STAGING_SHARED_MEMORY = "1";
      STAGING_WRITECOPY = "1";
    };
    systemPackages = with pkgs; [
      cemu
      dolphin-emu
      gpu-screen-recorder
      heroic
      lutris
      prismlauncher
      ryujinx
      tetrio-desktop
      xivlauncher
    ];
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    extraCompatPackages = with pkgs; [ proton-ge-bin ];
  };

  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };

  programs.gamemode = {
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

  hardware.opentabletdriver = {
    enable = true;
    daemon.enable = true;
  };
}
