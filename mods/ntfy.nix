{ config, ... }:

{
  services.ntfy-sh = {
    enable = true;
    settings = {
      base-url = "https://ntfy.froggo.garden/";
      listen-http = ":3001";
      behind-proxy = true;
      auth-default-access = "deny-all";
      auth-access = [ "*:up*:wo" ];
      enable-login = true;
    };
  };

  services.nginx.virtualHosts."ntfy.froggo.garden" = {
    locations."/" = {
      proxyPass = "http://localhost${toString config.services.ntfy-sh.settings.listen-http}";
      proxyWebsockets = true;
    };
    useACMEHost = "froggo-garden";
    forceSSL = true;
  };
}
