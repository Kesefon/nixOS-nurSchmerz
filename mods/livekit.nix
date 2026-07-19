{
  config,
  lib,
  pkgs,
  ...
}:
let

  keyFile = "/mnt/data/secrets/livekit.key";
in
{
  services.livekit = {

    enable = true;

    openFirewall = true;
    settings.room.auto_create = false;

    inherit keyFile;

  };
  services.lk-jwt-service = {

    enable = true;

    port = 8099;
    livekitUrl = "wss://livekit.froggo.garden/sfu";

    inherit keyFile;

  };

  # generate the key when needed
  systemd.services.livekit-key = {

    before = [
      "lk-jwt-service.service"
      "livekit.service"
    ];

    wantedBy = [ "multi-user.target" ];

    path = with pkgs; [
      livekit
      coreutils
      gawk
    ];

    script = ''
      echo "Key missing, generating key"
      echo "lk-jwt-service: $(livekit-server generate-keys | tail -1 | awk '{print $3}')" > "${keyFile}"
    '';
    serviceConfig.Type = "oneshot";
    unitConfig.ConditionPathExists = "!${keyFile}";

  };

  # restrict access to livekit room creation to a homeserver
  systemd.services.lk-jwt-service.environment.LIVEKIT_FULL_ACCESS_HOMESERVERS = "froggo.garden";
  services.nginx.virtualHosts."livekit.froggo.garden".locations = {

    "^~ /jwt/" = {

      priority = 400;

      proxyPass = "http://[::1]:${toString config.services.lk-jwt-service.port}/";

    };

    "^~ /sfu/" = {

      extraConfig = ''
        proxy_send_timeout 120;
        proxy_read_timeout 120;
        proxy_buffering off;

        proxy_set_header Accept-Encoding gzip;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
      '';

      priority = 400;

      proxyPass = "http://[::1]:${toString config.services.livekit.settings.port}/";

      proxyWebsockets = true;

    };

  };
}
