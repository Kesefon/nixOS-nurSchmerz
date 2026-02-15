{ ... }:

{
  services.sharkey = {
    enable = true;
    settings = {
      url = "https://froggo.garden/";
      id = "aid";
      mediaDirectory = "/mnt/data/sharkey/media";
    };
  };

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
      proxyPass = "http://localhost:3000";
    };
    useACMEHost = "froggo-garden";
    addSSL = true;
  };
}
