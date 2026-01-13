{ config, pkgs, lib, ... }:

{
  services.jellyfin = {
    enable = true;
    dataDir = "/mnt/data/jellyfin";
    hardwareAcceleration = {
      enable = true;
      type = "rkmpp";
      device = "/dev/dri/renderD128";
    };
    forceEncodingConfig = true;
    transcoding = {
      hardwareEncodingCodecs = {
        hevc = true;
        av1 = false;
      };
      hardwareDecodingCodecs = {
        vp9 = true;
        vp8 = true;
        hevc10bit = true;
        hevc = true;
        h264 = true;
        av1 = true;
      };
      enableHardwareEncoding = true;
    };
  };

  services.nginx.virtualHosts."watch.in.froggo.garden" = {
    locations."/" = {
      proxyPass = "http://localhost:8096";
      proxyWebsockets = true;
    };
    useACMEHost = "in-froggo-garden";
    addSSL = true;
  };
}
