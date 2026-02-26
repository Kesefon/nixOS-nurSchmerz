{ ... }:

{
  networking.nat = {
    enable = true;
    enableIPv6 = true;
    externalInterface = "ens6";
    internalInterfaces = [ "wg0" ];
  };

  systemd.network = {
    networks."50-wg0" = {
      matchConfig.Name = "wg0";

      address = [
        "fd42::/112"
        "10.10.10.3/24"
      ];

      networkConfig = {
        IPv4Forwarding = true;
        IPv6Forwarding = true;
      };
    };

    netdevs."50-wg0" = {
      netdevConfig = {
        Kind = "wireguard";
        Name = "wg0";
      };

      wireguardConfig = {
        ListenPort = 80;

        # ensure file is readable by `systemd-network` user
        PrivateKeyFile = "/mnt/data/secrets/wireguard/priv-key";

        # Automatically create routes for everything in AllowedIPs,
        RouteTable = "main";
      };
      wireguardPeers = [
        {
          # xperia
          PublicKey = "ronr+8v670J0CPb0xT5QLGMWDfE7+1g7HmC6YMdCIDk=";
          PresharedKeyFile = "/mnt/data/secrets/wireguard/preshared-xperia";
          AllowedIPs = [
            "fd42::1/128"
            "10.10.10.1/32"
          ];
          PersistentKeepalive = 15;
        }
        {
          # lptp
          PublicKey = "n40bUSYJNZNGrPQ7RW7ikRWOWu1iJsXQ4vSqjs3k/gE=";
          PresharedKeyFile = "/mnt/data/secrets/wireguard/preshared-lptp";
          AllowedIPs = [
            "fd42::2/128"
            "10.10.10.2/32"
          ];
          PersistentKeepalive = 15;
        }
        {
          # in.froggo.garden
          PublicKey = "ZRJkomSxF1AihG2l3UuANh/+ovJVgoJBZAAb4wRDuWE=";
          PresharedKeyFile = "/mnt/data/secrets/wireguard/preshared-in-froggo";
          AllowedIPs = [
            "fd42::3/128"
            "10.10.10.4/32"
          ];
          PersistentKeepalive = 15;
        }
      ];
    };
  };

  systemd.tmpfiles.settings = {
    "10-wireguard-keys" = {
      "/mnt/data/secrets/wireguard/priv-key" = {
        f = {
          user = "systemd-network";
          group = "systemd-network";
          mode = "640";
        };
      };
      "/mnt/data/secrets/wireguard/preshared-xperia" = {
        f = {
          user = "systemd-network";
          group = "systemd-network";
          mode = "640";
        };
      };
      "/mnt/data/secrets/wireguard/preshared-lptp" = {
        f = {
          user = "systemd-network";
          group = "systemd-network";
          mode = "640";
        };
      };
      "/mnt/data/secrets/wireguard/preshared-in-froggo" = {
        f = {
          user = "systemd-network";
          group = "systemd-network";
          mode = "640";
        };
      };
    };
  };
}
