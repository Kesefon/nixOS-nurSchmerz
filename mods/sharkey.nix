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

  services.nginx.virtualHosts."froggo.garden" = {
    locations."/" = {
      proxyPass = "http://localhost:3000";
    };
    useACMEHost = "froggo-garden";
    addSSL = true;
  };
}
