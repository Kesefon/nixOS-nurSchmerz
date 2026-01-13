{ config, pkgs, lib, ... }:

{
  services.jellyfin = {
    enable = true;
    dataDir = "/mnt/data/jellyfin";
  };

  services.nginx.virtualHosts."watch.in.froggo.garden" = {
    locations."/" = {
      proxyPass = "http://localhost:8096";
      proxyWebsockets = true;
    };
  };
}
