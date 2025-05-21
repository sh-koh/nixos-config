{
  config,
  pkgs,
  lib,
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
      lutris
      prismlauncher
      ryujinx
      (inputs'.xivlauncher-rb.packages.xivlauncher-rb.override {
        useGameMode = config.programs.gamemode.enable;
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
      settings = {
        general = {
          reaper_freq = 5;
          desiredgov = "performance";
          #desiredgov = "ondemand";
          softrealtime = "on";
          renice = 5;
          ioprio = 0;
          inhibit_screensaver = 1;
          disable_splitlock = 1;
        };
        cpu = {
          park_cores = "0-15";
          pin_cores = "0-15";
        };
        custom = {
          start = "${pkgs.libnotify}/bin/notify-send 'Gamemode enabled'";
          end = "${pkgs.libnotify}/bin/notify-send 'Gamemode disabled'";
        };
      };
    };
  };

  systemd.services.nvidia-overclock = {
    serviceConfig =
      let
        nvOverclockScript = (
          pkgs.writers.writePython3Bin "nvidia-overclock"
            {
              libraries = with pkgs.python312Packages; [
                nvidia-ml-py
                pynvml
              ];
            }
            ''
              import sys
              import pynvml as nv
              nv.nvmlInit()
              myGPU = nv.nvmlDeviceGetHandleByIndex(0)
              if sys.argv[1] == "on":
                  nv.nvmlDeviceSetPowerManagementLimit(myGPU, 200000)
                  nv.nvmlDeviceSetGpcClkVfOffset(myGPU, 140)
                  nv.nvmlDeviceSetMemClkVfOffset(myGPU, 1200)
              else:
                  nv.nvmlDeviceSetPowerManagementLimit(myGPU, 175000)
                  nv.nvmlDeviceSetGpcClkVfOffset(myGPU, 0)
                  nv.nvmlDeviceSetMemClkVfOffset(myGPU, 0)
            ''
        );
      in
      {
        Type = "simple";
        ExecStart = [
          ""
          "${lib.getExe nvOverclockScript} on"
        ];
        RemainAfterExit = "yes";
        ExecStop = [
          ""
          "${lib.getExe nvOverclockScript} off"
        ];
      };
  };

  hardware = {
    xpadneo.enable = true;
    opentabletdriver = {
      enable = true;
      daemon.enable = true;
    };
  };
}
