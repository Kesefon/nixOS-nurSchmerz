{ lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
      ../mods/server-base.nix
      ../mods/cert-in.froggo.garden.nix
      ../mods/nginx.nix
      ../mods/postgresql.nix
      ../mods/jellyfin.nix
      ../mods/komga.nix
      ../mods/mloader.nix
      ../mods/immich.nix
      ../mods/blocky.nix
      ../mods/tandoor.nix
    ];

  networking.hostName = "smolbox";

  networking.wg-quick.interfaces.froggo.configFile = "/mnt/data/secrets/wireguard.conf";

  system.autoUpgrade = {
    allowReboot = true;
    rebootWindow = {
      lower = "05:00";
      upper = "08:00";
    };
  };
  # Some updates require compiling huge programs which is a horrible idea on this teeny tiny SBC
  # Just kill the update if that happens
  systemd.services."nixos-upgrade".serviceConfig.MemoryMax = "5G";

  boot = {
    kernelPackages = pkgs.linuxPackages_testing;
    initrd.availableKernelModules = [ "nvme" "usb_storage" ];
  };
  hardware = {
    enableRedistributableFirmware = lib.mkForce true;
  };

  powerManagement.cpuFreqGovernor = "ondemand";

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/1b744d03-7367-4163-bfd1-b95cf5316955";
      fsType = "btrfs";
      options = [ "subvol=@" ];
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/1b744d03-7367-4163-bfd1-b95cf5316955";
      fsType = "btrfs";
      options = [ "subvol=@home" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/538E-489C";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };
  
  fileSystems."/mnt/data" =
    { device = "/dev/disk/by-uuid/cc9dffd2-5274-462c-8640-75888788aa7c";
      fsType = "ext4";
    };

  swapDevices = [ ];

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
}
