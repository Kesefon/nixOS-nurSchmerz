{ config, ... }:

{
  services.nginx.virtualHosts."read.in.froggo.garden" = {
    extraConfig = "
      proxy_ssl_server_name on;
      proxy_ssl_name read.in.froggo.garden;
      if ($geoip2_data_continent_code != EU) {
        return 403;
      }
    ";

    locations."/" = {
      proxyPass = "https://10.10.10.4:443";
    };
    useACMEHost = "froggo-garden";
    forceSSL = true;
  };
}
