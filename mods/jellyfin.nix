{ pkgs, ... }:

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

  services.udev.extraRules = ''
    KERNEL=="mpp_service", MODE="0660", GROUP="video"
    KERNEL=="rga", MODE="0660", GROUP="video"
    KERNEL=="system", MODE="0666", GROUP="video"
    KERNEL=="system-dma32", MODE="0666", GROUP="video"
    KERNEL=="system-uncached", MODE="0666", GROUP="video"
    KERNEL=="system-uncached-dma32", MODE="0666", GROUP="video" RUN+="${pkgs.coreutils}/bin/chmod a+rw /dev/dma_heap"
  '';
  users.users.jellyfin.extraGroups = [ "render" "video" ];
  environment.systemPackages = [ pkgs.armbian-firmware ];

  services.nginx.virtualHosts."watch.in.froggo.garden" = {
    locations."/" = {
      proxyPass = "http://localhost:8096";
      proxyWebsockets = true;
    };
    useACMEHost = "in-froggo-garden";
    addSSL = true;
  };
}
