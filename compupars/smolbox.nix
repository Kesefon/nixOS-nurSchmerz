{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  networking.hostName = "smolbox";

  boot = {
    kernelPackages = pkgs.linuxPackagesFor (pkgs.callPackage ./rk3588-kernel.nix {});
    supportedFilesystems = lib.mkForce [
      "vfat"
      "fat32"
      "exfat"
      "ext4"
      "btrfs"
    ];
    initrd.includeDefaultModules = lib.mkForce false;
    initrd.availableKernelModules = lib.mkForce [
    ];
  };
  hardware = {
    enableRedistributableFirmware = lib.mkForce true;
  };

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

  swapDevices = [ ];

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
}
