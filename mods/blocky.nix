{ config, pkgs, lib, ... }:

{
  services.blocky = {
    enable = true;
    settings = {
      upstreams.groups.default = [
        "tcp-tls:1.1.1.1:853"
        "tcp-tls:1.0.0.1:853"
      ];
      blocking = {
        denylists.ads = [
          "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts"
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
}
