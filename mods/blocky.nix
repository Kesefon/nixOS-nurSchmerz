{ ... }:

{
  services.blocky = {
    enable = true;
    settings = {
      upstreams.groups.default = [
        "tcp-tls:1.1.1.1:853"
        "tcp-tls:1.0.0.1:853"
        "sdns://AgcAAAAAAAAADjE4NS43MS4xMzguMTM4ABF3aWtpbWVkaWEtZG5zLm9yZwovZG5zLXF1ZXJ5" # Wikimedia IPv4
        "sdns://AgcAAAAAAAAAEVsyMDAxOjY3Yzo5MzA6OjFdABF3aWtpbWVkaWEtZG5zLm9yZwovZG5zLXF1ZXJ5" # Wikimedia IPv6
        "sdns://AwcAAAAAAAAACzUuOS4xNjQuMTEyBQIPDwJWFmRuczMuZGlnaXRhbGNvdXJhZ2UuZGU" # digitalcourage IPv4
        "sdns://AwcAAAAAAAAAFVsyYTAxOjRmODoyNTE6NTU0OjoyXQUCDw8CVhZkbnMzLmRpZ2l0YWxjb3VyYWdlLmRl" # digitalcourage IPv6
        "https://unfiltered.adguard-dns.com/dns-query"
        "sdns://AwMAAAAAAAAACzE5NC4yNDIuMi4yAA9kbnMubXVsbHZhZC5uZXQ" # Mullvad IPv4
        "sdns://AwMAAAAAAAAADlsyYTA3OmUzNDA6OjJdAA9kbnMubXVsbHZhZC5uZXQ" # Mullvad IPv6
        "sdns://AwMAAAAAAAAACjUuMS42Ni4yNTUADWRvdC5mZm11Yy5uZXQ" # Freifunk München IPv4
        "sdns://AwMAAAAAAAAAFVsyMDAxOjY3ODplNjg6ZjAwMDo6XQANZG90LmZmbXVjLm5ldA" # Freifunk München IPv6
        "https://dns.digitale-gesellschaft.ch/dns-query"
        "https://unicast.uncensoreddns.org/dns-query"
      ];
      blocking = {
        denylists.ads = [
          "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts"
          "https://oooo.b-cdn.net/blahdns/blahdns_hosts.txt"
        ];
        clientGroupsBlock.default = [ "ads" ];
      };
      conditional = {
        fallbackUpstream = false;
        mapping = {
          "fritz.box" = "192.168.2.1";
          "." = "192.168.2.1";
        };
      };
      ports = {
        dns = 53;
        http = [ "127.0.0.1:4000" ];
      };
    };
  };

  networking.firewall = {
    allowedTCPPorts = [ 53 ];
    allowedUDPPorts = [ 53 ];
  };
}
