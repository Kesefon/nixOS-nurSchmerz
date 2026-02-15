{ config, ... }:

{
  services.komga = {
    enable = true;
    stateDir = "/mnt/data/komga";
    settings.server.port = 8097;
  };

  services.nginx.virtualHosts."read.in.froggo.garden" = {
    locations."/" = {
      proxyPass = "http://localhost:${toString config.services.komga.settings.server.port}";
    };
    useACMEHost = "in-froggo-garden";
    forceSSL = true;
  };
}
