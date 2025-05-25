{ config, ... }:
{
  programs.vesktop = {
    enable = true;
    # https://github.com/Vencord/Vesktop/blob/main/src/shared/settings.d.ts
    settings = {
      checkUpdates = false;
      discordBranch = "canary";
      transparencyOption = "none";
      tray = false;
      minimizeToTray = false;
      openLinksWithElectron = false;
      staticTitle = true;
      enableMenu = true;
      disableSmoothScroll = false;
      hardwareAcceleration = true;
      arRPC = true;
      appBadge = true;
      disableMinSize = true;
      clickTrayToShowHide = false;
      customTitleBar = false;
      enableSplashScreen = true;
      splashTheming = true;
      splashColor = config.lib.stylix.colors.withHashtag.base05;
      splashBackground = config.lib.stylix.colors.withHashtag.base00;
      spellCheckLanguages = true;
    };
    # https://github.com/Vendicated/Vencord/blob/main/src/api/Settings.ts
    vencord = {
      useSystem = false;
      settings = {
        autoUpdate = true;
        autoUpdateNotification = true;
        useQuickCss = true;
        enableReactDevtools = false;
        frameless = true;
        transparent = false;
        winCtrlQ = false;
        disableMinSize = true;
        winNativeTitleBar = false;
        notifications = {
          useNative = "not-focused";
          position = "bottom-right";
          timeout = 5000;
          logLimit = 50;
        };
        plugins = {
          CustomIdle = {
            enabled = true;
            idleTimeout = 0;
            remainInIdle = false;
          };
          CrashHandler.enabled = true;
          WebKeybinds.enabled = true;
          WebScreenShareFixes.enabled = true;
          WhoReacted.enabled = true;
          YoutubeAdblock.enabled = true;
        };
      };
    };
  };
}
