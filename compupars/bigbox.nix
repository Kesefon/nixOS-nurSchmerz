{
  config,
  lib,
  pkgs,
  modulesPath,
  inputs,
  globals,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ../mods/desktop-base.nix
  ];

  networking.hostName = "bigbox";

  services.xserver.xkb = {
    layout = "us";
    variant = "de_se_fi";
  };
  console.keyMap = "us";

  services.homed.enable = true;
  users.users."${globals.userinfo.username}".enable = false;
  environment.systemPackages = [
    inputs.zen-browser.packages."${pkgs.stdenv.hostPlatform.system}".default
  ];

  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "ahci"
    "usb_storage"
    "usbhid"
    "sd_mod"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/mapper/luks-1676909a-2854-4c25-a8aa-9f08f77a21ab";
    fsType = "btrfs";
  };

  boot.initrd.luks.devices."luks-1676909a-2854-4c25-a8aa-9f08f77a21ab".device =
    "/dev/disk/by-uuid/1676909a-2854-4c25-a8aa-9f08f77a21ab";

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/D14B-58CF";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  };

  swapDevices = [ ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
