{
  config,
  pkgs,
  lib,
  ...
}:
{
  boot = {
    kernelPackages = lib.mkForce pkgs.linuxKernel.packages.linux_xanmod_latest;
    kernelParams = [
      "mitigations=off"
      "spectre_v2=off"
      "preempt=full"
    ];
    kernel.sysctl = {
      "kernel.sched_cfs_bandwidth_slice_us" = 3000;
      "net.ipv4.tcp_fin_timeout" = 5;
      "kernel.split_lock_mitigate" = 0;
      "vm.max_map_count" = 2147483642;
    };
  };

  environment = {
    variables = {
      STAGING_SHARED_MEMORY = "1";
      STAGING_WRITECOPY = "1";
      WINE_LARGE_ADDRESS_AWARE = "1";
      WINE_SIMULATE_WRITECOPY = "1";
    };
    systemPackages = with pkgs; [
      cemu
      dolphin-emu
      lutris
      prismlauncher
      ryujinx
      (xivlauncher-rb.override {
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
      #capSysNice = true;
    };

    gamemode = {
      enable = true;
      enableRenice = true;
      settings = {
        general = {
          reaper_freq = 5;
          desiredgov = "performance";
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
