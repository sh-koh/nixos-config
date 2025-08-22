{
  config,
  pkgs,
  lib,
  ...
}:
{
  boot = {
    kernelPackages = lib.mkForce pkgs.linuxKernel.packages.linux_xanmod_latest;
    kernelModules = [ "ntsync" ];
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
      WINE_DISABLE_HARDWARE_SCHEDULING = "0";
      PROTON_ENABLE_WAYLAND = "1";
      PROTON_ENABLE_HIDRAW = "1";
      PROTON_USE_NTSYNC = "1";
      PROTON_USE_WOW64 = "1";
    };
    systemPackages = with pkgs; [
      cemu
      dolphin-emu
      lutris
      prismlauncher
      ryubing
      (xivlauncher-rb.override {
        nvngxPath = "${config.hardware.nvidia.package}/lib/nvidia/wine";
      })
      fflogs
    ];
  };

  services = {
    lact.enable = true;
    udev.packages = [
      (pkgs.writeTextFile {
        name = "ntsync-udev-rules";
        destination = "/etc/udev/rules.d/70-ntsync.rules";
        text = ''KERNEL=="ntsync", MODE="0660", TAG+="uaccess"'';
      })
    ];
    sunshine = {
      enable = true;
      autoStart = false;
      capSysAdmin = true;
    };
  };

  networking.firewall = {
    interfaces =
      let
        genPorts = port: offsets: map (offset: port + offset) offsets;
      in
      {
        "${
          {
            atrebois = "enp34s0";
            rocaille = "wlan0";
          }
          .${config.networking.hostName}
        }" =
          {
            allowedTCPPorts = genPorts config.services.sunshine.settings.port [
              (-5)
              0
              1
              21
            ];
            allowedUDPPorts = genPorts config.services.sunshine.settings.port [
              9
              10
              11
              13
              21
            ];
          };
      };
  };

  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      extraCompatPackages = with pkgs; [ proton-ge-bin ];
    };
    gamescope = {
      enable = true;
      capSysNice = false;
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

  hardware = {
    xpadneo.enable = true;
    opentabletdriver = {
      enable = true;
      daemon.enable = true;
    };
  };
}
