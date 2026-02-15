{ ... }:

{
  # We use port 80 to avoid strict firewalls in public wifis
  networking.wg-quick.interfaces.froggo.configFile = "/mnt/data/secrets/wireguard.conf";

  networking.firewall.allowedUDPPorts = [ 80 ];
}
