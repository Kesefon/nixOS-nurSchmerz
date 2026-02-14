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
      enable-login = true;
      attachment-cache-dir = "/mnt/data/ntfy/attachmments";
    };
  };

  systemd.tmpfiles.settings = {
    "10-ntfy-data" = {
      "/mnt/data/ntfy" = {
        d = {
          user = "ntfy-sh";
          group = "ntfy-sh";
          mode = "400";
        };
      };
    };
  };

  services.nginx.virtualHosts."ntfy.froggo.garden" = {
    locations."/" = {
      proxyPass = "http://localhost${toString config.services.ntfy-sh.settings.listen-http}";
    };
    useACMEHost = "froggo-garden";
    addSSL = true;
  };
}
