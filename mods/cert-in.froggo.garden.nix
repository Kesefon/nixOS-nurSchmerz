{ ... }:

{
  security.acme = {
    acceptTerms = true;
    certs."in-froggo-garden" = {
      environmentFile = /mnt/data/secrets/cloudflare-dns-creds;
      dnsProvider = "cloudflare";
      domain = "*.in.froggo.garden";
    };
    defaults.email = "acme@froggo.garden";
  };

  systemd.tmpfiles.settings = {
    "10-cloudflare-dns-creds" = {
      "/mnt/data/secrets/cloudflare-dns-creds" = {
        f = {
          user = "acme";
          group = "acme";
          mode = "400";
        };
      };
    };
  };
}
