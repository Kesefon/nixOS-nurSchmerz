{
  programs.plasma = {
    enable = true;
    input = {
      mice = [
        {
          acceleration = 0;
          accelerationProfile = "none";
          enable = true;
          leftHanded = true;
          middleButtonEmulation = false;
          naturalScroll = false;
          scrollSpeed = 1;

          name = "SteelSeries SteelSeries Rival 600";
          vendorId = "1038";
          productId = "1724";
        }
      ];
      touchpads = [
        {
          leftHanded = false;
          disableWhileTyping = false;
          naturalScroll = false;
          twoFingerTap = "middleClick";

          name = "XXXX0000:05 0911:5288 Touchpad";
          vendorId = "0911";
          productId = "5288";
        }
      ];
    };
    shortcuts = {
      kwin."Window Close" = "Meta+Shift+Q";
      "org.kde.konsole.desktop"."_launch" = "Meta+Return";
    };
    workspace = {
      clickItemTo = "select";
      lookAndFeel = "org.kde.breezedark.desktop";
      cursor = {
        theme = "Banana";
        size = 40;
      };
    };
    fonts = {
      fixedWidth = {
        family = "Comic Mono";
        pointSize = 11;
      };
    };
    kwin = {
      cornerBarrier = true;
      edgeBarrier = 100;
      effects = {
        shakeCursor.enable = true;
        wobblyWindows.enable = true;
      };
      nightLight = {
        enable = true;
        mode = "automatic";
        temperature = {
          day = 6500;
          night = 3100;
        };
      };
      titlebarButtons = {
        left = [ "keep-above-windows" ];
        right = [ "minimize" "maximize" "close" ];
      };
      virtualDesktops.number = 1;
    };
    panels = [
      {
        alignment = "center";
        floating = true;
        height = 44;
        hiding = "autohide";
        lengthMode = "fit";
        location = "left";
        opacity = "adaptive";
        widgets = [
          "org.kde.plasma.kickoff"
          {
            iconTasks = {
              launchers = [
                "applications:kdesystemsettings.desktop"
                "applications:org.kde.dolphin.desktop"
                "preferred://browser"
                "applications:org.kde.konsole.desktop"
              ];
            };
          }
        ];
      }
      {
        alignment = "left";
        floating = false;
        height = 20;
        hiding = "windowsgobelow";
        location = "top";
        lengthMode = "custom";
        minLength = 0;
        maxLength = 500;
        offset = 140;
        opacity = "translucent";
        widgets = [
          "org.kde.plasma.systemtray"
          {
            digitalClock = {
              date = {
                format = "isoDate";
                position = "besideTime";
              };
              time = {
                showSeconds = "onlyInTooltip";
                format = "24h";
              };
            };
          }
        ];
      }
    ];
    window-rules = [
      {
        description = "Firefox PiP";
        match = {
          title = {
            value = "Picture-in-Picture";
            type = "exact";
          };
        };
        apply = {
          above = true;
        };
      }
    ];
    hotkeys.commands."launch-konsole" = {
      name = "Launch Konsole";
      key = "Meta+Return";
      command = "konsole";
    };
    session.sessionRestore.restoreOpenApplicationsOnLogin = "startWithEmptySession";
    configFile = {
      baloofilerc."Basic Settings".Indexing-Enabled = false;
      dolphinrc.General.ConfirmClosingMultipleTabs = false;
      dolphinrc.General.RememberOpenedTabs = false;
       #TODO Ctrl+F for filter in dolphin
      kcminputrc.Mouse.XLbInptLeftHanded = true;
      kdeglobals.General.AccentColor = "255,0,153";
      kdeglobals."KFileDialog Settings"."Show hidden files" = true;
      plasmaparc.General.RaiseMaximumVolume = true;
      spectaclerc.ImageSave.imageFilenameTemplate = "📺📸-<yyyy><MM><dd>_<HH><mm><ss>-<title>";
      spectaclerc.VideoSave.videoFilenameTemplate = "📺📹-<yyyy><MM><dd>_<HH><mm><ss>-<title>";
    };
    dataFile = {
      "dolphin/view_properties/global/.directory".Settings.HiddenFilesShown = true;
      #TODO Downloads sorted by recent?
    };
  };
}
