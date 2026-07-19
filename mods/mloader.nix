{ pkgs, ... }:
let
  mloader-fork = (pkgs.callPackage ./mloader-fork.nix { });

in
{
  environment.systemPackages = [
    mloader-fork
  ];

  systemd.services.mloader = {
    after = [ "network.target" ];
    description = "Download Manga+";
    serviceConfig = {
      Type = "oneshot";
      DynamicUser = true;
      ReadWritePaths = "/mnt/data/share/eBook/Manga+/";
      Environment = "PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION=python";
      ExecStart = "${mloader-fork}/bin/mloader -m -o /mnt/data/share/eBook/Manga+/ --chapter-subdir https://mangaplus.shueisha.co.jp/titles/100644 https://mangaplus.shueisha.co.jp/titles/100037 https://mangaplus.shueisha.co.jp/titles/100171 https://mangaplus.shueisha.co.jp/titles/100056 ";
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
