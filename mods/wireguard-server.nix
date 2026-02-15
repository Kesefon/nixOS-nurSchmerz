{ ... }:

{
  networking.wg-quick.interfaces.froggo.configFile = "/mnt/data/secrets/wireguard.conf";

  services.nginx.streamConfig = "
    server {
      listen 127.0.0.1:80 udp reuseport;
      proxy_timeout 20s;
      proxy_pass 192.168.0.1:8095;
    }
  ";
}
