{ lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
      ../mods/base.nix
      ../mods/cert-froggo.garden.nix
      ../mods/nginx.nix
      ../mods/postgresql.nix
      ../mods/sharkey.nix
      ../mods/ntfy.nix
    ];

  networking.hostName = "cloudbox";

  networking.wg-quick.interfaces.froggo.configFile = "/mnt/data/secrets/wireguard.conf";

  system.autoUpgrade = {
    allowReboot = true;
    rebootWindow = {
      lower = "05:00";
      upper = "08:00";
    };
  };

  boot.initrd.kernelModules = [ "virtio_gpu" ];
  boot.kernelParams = [ "console=tty" ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/e686ffd9-f21d-4c77-8960-5f3b80fe068f";
      fsType = "btrfs";
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
