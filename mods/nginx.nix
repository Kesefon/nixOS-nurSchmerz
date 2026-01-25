{ ... }:

{
  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    recommendedOptimisation = true;
    recommendedGzipSettings = true;
  };
  networking.firewall.allowedTCPPorts = [ 80 443 ];
  users.users.nginx.extraGroups = [ "acme" ];
}
