{ ... }:

{
  # We use port 80 to avoid strict firewalls in public wifis
  networking.wg-quick.interfaces.froggo.configFile = "/mnt/data/secrets/wireguard.conf";

  networking.firewall.allowedUDPPorts = [ 80 ];

  services.nginx.streamConfig = "
    server {
      listen 80 udp;
      proxy_pass 192.168.0.1:8095;
    }
  ";
}
