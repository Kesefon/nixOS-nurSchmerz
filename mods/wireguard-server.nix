{ ... }:

{
  networking.wg-quick.interfaces.froggo.configFile = "/mnt/data/secrets/wireguard.conf";

  services.nginx.streamConfig = "
    server {
      listen 80 udp;
      proxy_pass 192.168.0.1:8095;
    }
  ";
}
