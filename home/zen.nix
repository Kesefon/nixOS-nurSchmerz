{ pkgs, lib, ... }:
{
  programs.zen-browser = {
    enable = true;
    setAsDefaultBrowser = true;
    profiles.default = {
      extensions = {
        force = true;
      };
      settings = {
        "browser.contentblocking.category" = "strict";
        "browser.download.useDownloadDir" = false;
        "browser.newtabpage.activity-stream.feeds.topsites" = true;
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.showWeather" = false;
        "widget.use-xdg-desktop-portal.file-picker" = 1;
        "zen.welcome-screen.seen" = true;
      };
      search = {
        force = true;
        default = "ddg";
        engines = {
          nixpkgs = {
            name = "Nixpkgs";
            urls = [
              {
                template = "https://search.nixos.org/packages?query={searchTerms}";
                params = [
                  {
                    name = "query";
                    value = "searchTerms";
                  }
                ];
              }
            ];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = ["@np"];
          };
          nixopts = {
            name = "NixOS options";
            urls = [
              {
                template = "https://search.nixos.org/options?query={searchTerms}";
                params = [
                  {
                    name = "query";
                    value = "searchTerms";
                  }
                ];
              }
            ];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = ["@no"];
          };
          archwiki = {
            name = "Arch Wiki";
            urls = [
              {
                template = "https://wiki.archlinux.org/index.php?search={searchTerms}";
                params = [
                  {
                    name = "query";
                    value = "searchTerms";
                  }
                ];
              }
            ];
            definedAliases = ["@aw"];
          };
          github = {
            name = "GitHub";
            urls = [
              {
                template = "https://github.com/search?q={searchTerms}";
                params = [
                  {
                    name = "query";
                    value = "searchTerms";
                  }
                ];
              }
            ];
            definedAliases = ["@gh"];
          };
        };
      };
    };
    policies = let
      mkExtensionSettings = builtins.mapAttrs (_: pluginId: {
        install_url = "https://addons.mozilla.org/firefox/downloads/latest/${pluginId}/latest.xpi";
        installation_mode = "force_installed";
      });
    in {
      ExtensionSettings = mkExtensionSettings {
        "uBlock0@raymondhill.net" = "ublock-origin";
        "jid1-BoFifL9Vbdl2zQ@jetpack" = "decentraleyes";
        "firefox-extension@steamdb.info" = "steam-database";
        "streetpass@streetpass.social" = "streetpass-for-mastodon";
      };
      AutofillAddressEnabled = false;
      AutofillCreditCardEnabled = false;
      DisableAppUpdate = true;
      DisableFeedbackCommands = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableTelemetry = true;
      DontCheckDefaultBrowser = true;
      NoDefaultBookmarks = true;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
      "3rdparty".Extensions = {
        "uBlock0@raymondhill.net".adminSettings = {
          userSettings = rec {
            advancedUserEnabled = true;
            cloudStorageEnabled = false;

            importedLists = [
              "https://raw.githubusercontent.com/gijsdev/ublock-hide-yt-shorts/master/list.txt"
            ];

            externalLists = lib.concatStringsSep "\n" importedLists;
          };

          selectedFilterLists = [
          "ublock-filters"
          "ublock-badware"
          "ublock-privacy"
          "ublock-quick-fixes"
          "ublock-unbreak"
          "easylist"
          "easyprivacy"
          "urlhaus-1"
          "plowe-0"
          "fanboy-cookiemonster"
          "ublock-cookies-easylist"
          "adguard-cookies"
          "ublock-cookies-adguard"
          "fanboy-thirdparty_social"
          "easylist-chat"
          "easylist-newsletters"
          "adguard-mobile-app-banners"
          "adguard-popup-overlays"
          "DEU-0"
          "https://raw.githubusercontent.com/gijsdev/ublock-hide-yt-shorts/master/list.txt"
          ];
        };
      };
    };
  };
}
