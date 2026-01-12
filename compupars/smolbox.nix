{ config, lib, pkgs, modulesPath, ... }:
let
  rockchip_kernel = pkgs.buildLinux rec {
    modDirVersion = "6.1.75";
    version = "6.1.75-rk";
    extraMeta.branch = "6.1";
    src = pkgs.fetchFromGitHub {
      owner = "Joshua-Riek";
      repo = "linux-rockchip";
      rev = "e21cf49ee9a41a02846da050a6930e317bc99b68";
      hash = "sha256-gAI8BuZDG7hq8MmbCnjwLSKwcYxKsGcyerXlKBTbL+U=";
    };
    configfile = ./ubuntu-rockchip-kernel-config;
  };
in
{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  networking.hostName = "smolbox";

  boot.initrd.includeDefaultModules = lib.mkForce false;
  #boot.initrd.allowMissingModules = true;

  boot.kernelPackages = (pkgs.linuxPackagesFor rockchip_kernel);

  boot.initrd.availableKernelModules = lib.mkForce [ ];
  boot.kernelModules = lib.mkForce [ ];
  boot.initrd.kernelModules = lib.mkForce [ ];

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
