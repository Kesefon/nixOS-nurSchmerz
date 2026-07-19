{ config, pkgs, ... }:

{
  imports = [
    ./livekit.nix
  ];

  services.matrix-tuwunel = {
    enable = true;
    settings = {
      global = {
        server_name = "froggo.garden";
        port = [ 4000 ];
        allow_registration = false;
        allow_federation = true;
        allow_encryption = true;
      };
      "global.well_known" = {
        client = "https://matrix.froggo.garden";
        server = "matrix.froggo.garden:443";
      };
    };
  };

  services.nginx.virtualHosts = {
    "matrix.froggo.garden" = {
      locations."/" = {
        proxyPass = "http://localhost:${toString config.services.matrix-tuwunel.settings.global.port}";
      };
      useACMEHost = "froggo-garden";
      forceSSL = true;
    };
    "froggo.garden" = {
      locations."/.well-known/matrix/server" = {
        return = "200 '${builtins.toJSON { "m.server" = "matrix.froggo.garden:443"; }}'";
        extraConfig = "
          add_header Content-Type application/json;
          add_header Access-Control-Allow-Origin '*';
        ";
      };
      locations."/.well-known/matrix/client" = {
        return = "200 '${
          builtins.toJSON {
            "m.homeserver" = {
              "base_url" = "https://matrix.froggo.garden";
            };
            "org.matrix.msc3575.proxy" = {
              "url" = "https://matrix.froggo.garden";
            };
            "org.matrix.msc4143.rtc_foci" = [
              {
                "type" = "livekit";
                "livekit_service_url" = "https://livekit.froggo.garden/jwt";
              }
            ];
          }
        }'";
        extraConfig = "
          add_header Content-Type application/json;
          add_header Access-Control-Allow-Origin '*';
        ";
      };
      useACMEHost = "froggo-garden";
      forceSSL = true;
    };
  };
}
