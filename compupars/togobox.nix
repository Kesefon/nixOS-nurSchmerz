{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

  networking.hostName = "togobox";

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  console.keyMap = "us";

  hardware.bluetooth.enable = true;

  services.xserver.displayManager.setupCommands = [
      "${lib.kdePackages.libkscreen}/bin/kscreen-doctor output.DSI-1.rotation.right"
    ];

  boot.loader.systemd-boot.consoleMode = "0"; # wrong orientation but at least you can read the entries

  hardware.chuwi-minibook-x = {
    mountMatrix = "0,-1,0;1,0,0;0,0,1";
    tabletMode.enable = true;
  };
  environment.systemPackages = with pkgs; [
    maliit-keyboard
  ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" "sdhci_pci" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/mapper/luks-d38294ea-6acb-48f9-8e74-6dccbd7456cb";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."luks-d38294ea-6acb-48f9-8e74-6dccbd7456cb".device = "/dev/disk/by-uuid/d38294ea-6acb-48f9-8e74-6dccbd7456cb";

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/49D2-88F6";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  swapDevices =
    [ { device = "/dev/mapper/luks-95833294-e601-4ae3-b14c-52979e94d750"; }
    ];

  boot.initrd.luks.devices."luks-95833294-e601-4ae3-b14c-52979e94d750".device = "/dev/disk/by-uuid/95833294-e601-4ae3-b14c-52979e94d750";

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
