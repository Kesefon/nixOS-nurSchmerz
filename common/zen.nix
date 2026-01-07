{
  inputs,
  pkgs,
  lib,
  ...
}:
let
  extension = shortId: guid: {
    name = guid;
    value = {
      install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortId}/latest.xpi";
      installation_mode = "normal_installed";
    };
  };

  prefs = {
    "browser.contentblocking.category" = "strict";
    "extensions.pocket.enabled" = false;
    "browser.download.useDownloadDir" = false;
    "browser.newtabpage.activity-stream.feeds.topsites" = true;
    "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
    "browser.newtabpage.activity-stream.showSponsored" = false;
    "browser.newtabpage.activity-stream.showWeather" = false;
    "extensions.formautofill.creditCards.enabled" = false;
    "privacy.firstparty.isolate" = true;
    "widget.use-xdg-desktop-portal.file-picker" = 1;
    "zen.welcome-screen.seen" = true;
  };

  extensions = [
    # To add additional extensions, find it on addons.mozilla.org, find
    # the short ID in the url (like https://addons.mozilla.org/en-US/firefox/addon/!SHORT_ID!/)
    # Then go to https://addons.mozilla.org/api/v5/addons/addon/!SHORT_ID!/ to get the guid
    (extension "ublock-origin" "uBlock0@raymondhill.net")
    (extension "decentraleyes" "jid1-BoFifL9Vbdl2zQ@jetpack")
    (extension "steam-database" "firefox-extension@steamdb.info")
    (extension "streetpass-for-mastodon" "streetpass@streetpass.social")
  ];

in
{
  environment.systemPackages = [
    (pkgs.wrapFirefox
      inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.zen-browser-unwrapped
      {
        extraPrefs = lib.concatLines (
          lib.mapAttrsToList (
            name: value: ''lockPref(${lib.strings.toJSON name}, ${lib.strings.toJSON value});''
          ) prefs
        );

        extraPolicies = {
          DisableTelemetry = true;
          ExtensionSettings = builtins.listToAttrs extensions;
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

          SearchEngines = {
            Default = "ddg";
            Add = [
              {
                Name = "nixpkgs packages";
                URLTemplate = "https://search.nixos.org/packages?query={searchTerms}";
                IconURL = "https://wiki.nixos.org/favicon.ico";
                Alias = "@np";
              }
              {
                Name = "NixOS options";
                URLTemplate = "https://search.nixos.org/options?query={searchTerms}";
                IconURL = "https://wiki.nixos.org/favicon.ico";
                Alias = "@no";
              }
              {
                Name = "NixOS Wiki";
                URLTemplate = "https://wiki.nixos.org/w/index.php?search={searchTerms}";
                IconURL = "https://wiki.nixos.org/favicon.ico";
                Alias = "@nw";
              }
              {
                Name = "ArchWiki";
                URLTemplate = "https://wiki.archlinux.org/index.php?search={searchTerms}";
                IconURL = "https://archlinux.org/favicon.ico";
                Alias = "@aw";
              }
            ];
          };
        };
      }
    )
  ];
}
