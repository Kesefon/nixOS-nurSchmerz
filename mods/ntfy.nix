{ config, ... }:

{
  services.ntfy-sh = {
    enable = true;
    settings = {
      base-url = "https://ntfy.froggo.garden/";
      listen-http = ":3001";
      behind-proxy = true;
      auth-file = "/mnt/data/ntfy/user.db";
      auth-default-access = "deny-all";
      auth-access = [ "*:up*:wo" ];
      enable-login = true;
      attachment-cache-dir = "/mnt/data/ntfy/attachmments";
    };
  };

  systemd.services.ntfy-sh.serviceConfig.ReadWritePaths = [ "/mnt/data/ntfy/" ];

  systemd.tmpfiles.settings = {
    "10-ntfy-data" = {
      "/mnt/data/ntfy" = {
        d = {
          user = "ntfy-sh";
          group = "ntfy-sh";
          mode = "770";
        };
      };
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
