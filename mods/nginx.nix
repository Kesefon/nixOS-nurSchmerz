{ ... }:

{
  imports = [
    ./nginx-geoip.nix
  ];

  services.nginx = {
    enable = true;
    recommendedTlsSettings = true;
    recommendedOptimisation = true;
    recommendedGzipSettings = true;
    commonHttpConfig = "
      proxy_set_header        Host $host;
      proxy_set_header        X-Real-IP $remote_addr;
      proxy_set_header        X-Forwarded-For $remote_addr;
      proxy_set_header        X-Forwarded-Proto $scheme;
      proxy_set_header        X-Forwarded-Host $host;
      proxy_set_header        X-Forwarded-Server $hostname;
      set_real_ip_from        fd42::/112;
      set_real_ip_from        10.10.10.0/24;
    ";
  };
  networking.firewall.allowedTCPPorts = [
    80
    443
  ];
  users.users.nginx.extraGroups = [ "acme" ];

  services.nginx.virtualHosts."_" = {
    default = true;
    rejectSSL = true;
    extraConfig = "
      deny all;
    ";
  };
}
