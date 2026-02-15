{ config, ... }:

{
  services.sharkey = {
    enable = true;
    settings = {
      url = "https://froggo.garden/";
      id = "aid";
      mediaDirectory = "/mnt/data/sharkey/media";
    };
  };

  users.groups.sharkey = {
  };

  users.users.sharkey =  {
    isSystemUser = true;
    group = "sharkey";
  };

  systemd.services.sharkey.serviceConfig.User = "sharkey";

  systemd.services.sharkey.serviceConfig.Group = "sharkey";

  systemd.tmpfiles.settings = {
    "10-sharkey-media" = {
      "/mnt/data/sharkey/media" = {
        d = {
          user = "sharkey";
          group = "sharkey";
          mode = "660";
        };
      };
    };
  };

  services.nginx.virtualHosts."froggo.garden" = {
    locations."/" = {
      proxyPass = "http://localhost:${toString config.services.sharkey.settings.port}";
      proxyWebsockets = true;
    };
    useACMEHost = "froggo-garden";
    forceSSL = true;
  };
}
