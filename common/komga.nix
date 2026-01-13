{ config, pkgs, lib, ... }:

{
  services.komga = {
    enable = true;
    stateDir = "/mnt/data/komga";
    settings.server.port = 8097;
  };

  services.nginx.virtualHosts."read.in.froggo.garden" = {
    locations."/" = {
      proxyPass = "http://localhost:8097";
    };
    useACMEHost = "in-froggo-garden";
    addSSL = true;
  };
}
