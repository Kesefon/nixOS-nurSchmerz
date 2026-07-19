{ config, ... }:

{
  services.tandoor-recipes = {
    enable = true;
    address = "localhost";
    extraConfig = {
      ALLOWED_HOSTS = "cook.in.froggo.garden";
    };
    database.createLocally = true;
    extraConfig.MEDIA_ROOT = "/var/lib/tandoor-recipes/media";
    port = 8099;
  };

  services.nginx.virtualHosts."${toString config.services.tandoor-recipes.extraConfig.ALLOWED_HOSTS}" =
    {
      locations."/media/" = {
        alias = "${config.services.tandoor-recipes.extraConfig.MEDIA_ROOT}";
      };
      locations."/" = {
        proxyPass = "http://localhost:${toString config.services.tandoor-recipes.port}";
      };
      useACMEHost = "in-froggo-garden";
      forceSSL = true;
    };
}
