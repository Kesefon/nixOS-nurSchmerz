{ config, pkgs, lib, ... }:

{
  services.immich = {
    enable = true;
    port = 8098;
    mediaLocation = "/mnt/data/share/Picture";
    accelerationDevices = [ "/dev/dri/renderD128" ];    
  };

  services.nginx.virtualHosts."pics.in.froggo.garden" = {
    locations."/" = {
      proxyPass = "http://localhost:8098";
    };
  };
}
