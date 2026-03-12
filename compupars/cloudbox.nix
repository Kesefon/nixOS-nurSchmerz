{ lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
      ../mods/server-base.nix
      ../mods/cert-froggo.garden.nix
      ../mods/nginx.nix
      ../mods/postgresql.nix
      ../mods/sharkey.nix
      ../mods/ntfy.nix
      ../mods/wireguard-server.nix
      ../mods/tuwunel.nix
      ../mods/element.nix
    ];

  networking.hostName = "cloudbox";

  system.autoUpgrade = {
    allowReboot = true;
    rebootWindow = {
      lower = "05:00";
      upper = "08:00";
    };
  };

  boot.initrd.kernelModules = [ "virtio_gpu" ];
  boot.initrd.availableKernelModules = [ "xhci_pci" "virtio_pci" "virtio_scsi" "usbhid" "sr_mod" ];
  boot.kernelParams = [ "console=tty" ];

  networking.networkmanager.enable = false;
  systemd.network = {
    enable = true;

    networks."10-wan" = {
      matchConfig.Name = "enp1s0";
      networkConfig.DHCP = "ipv4";
      address = [
        "2a01:4f8:c012:431::1/64"
      ];
      routes = [
        { routeConfig.Gateway = "fe80::1"; }
      ];
    };
  };

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/e1faf9aa-5d79-490e-89df-265ad6d0ae23";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/0F90-1F20";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  fileSystems."/mnt/data" =
    { device = "/dev/disk/by-id/scsi-0HC_Volume_37350203";
      fsType = "xfs";
    };

  swapDevices = [ ];

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
}
