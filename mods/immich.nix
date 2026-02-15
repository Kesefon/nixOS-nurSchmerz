{ config, ... }:

{
  services.immich = {
    enable = true;
    port = 8098;
    mediaLocation = "/mnt/data/share/Picture";
    accelerationDevices = [ "/dev/dri/renderD128" ];    
  };
  users.users.immich.extraGroups = [ "render" "video" ];

  services.nginx.virtualHosts."pics.in.froggo.garden" = {
    locations."/" = {
      proxyPass = "http://localhost:${toString config.services.immich.port}";
      proxyWebsockets = true;
      extraConfig = "

        # allow large file uploads
        client_max_body_size 50000M;

        # disable buffering uploads to prevent OOM on reverse proxy server and make uploads twice as fast (no pause)
        proxy_request_buffering off;

        # increase body buffer to avoid limiting upload speed
        client_body_buffer_size 1024k;

        # set timeout
        proxy_read_timeout 600s;
        proxy_send_timeout 600s;
        send_timeout       600s;
      ";
    };
    useACMEHost = "in-froggo-garden";
    forceSSL = true;
  };
}
