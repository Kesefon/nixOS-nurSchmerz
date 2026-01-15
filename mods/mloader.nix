{ config, pkgs, lib, ... }:

{
  environment.systemPackages = [
    (pkgs.mloader.overrideAttrs (previousAttrs: {
        patches = [
          (pkgs.fetchpatch {
            name = "comi-xml.patch";
            url = "https://github.com/Kesefon/mloader/commit/0e1d7e5301aee16581a4d498f552ede36684fc95.patch";
            hash = "sha256-pxQyrX7fqCvdkOUat6ttwt4VL/JA+l4TfOrP5RVBwww=";
          })
        ];
      }))
  ];

  systemd.services.mloader = {
    after = [ "network.target" ];
    description = "Download Manga+";
    serviceConfig = {
      Type = "oneshot";
      DynamicUser = true;
      ReadWritePaths="/mnt/data/share/eBook/Manga+/";
      Environment = "PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION=python";
      ExecStart = ''${pkgs.mloader}/bin/mloader -o /mnt/data/share/eBook/Manga+/ --chapter-subdir https://mangaplus.shueisha.co.jp/titles/100644 https://mangaplus.shueisha.co.jp/titles/100037 https://mangaplus.shueisha.co.jp/titles/100171 https://mangaplus.shueisha.co.jp/titles/100056 '';
    };
  };

  systemd.timers.mloader = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "weekly";
      Persistent = true;
    };
  };
}
