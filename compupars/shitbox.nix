{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  networking.hostName = "shitbox";

  environment.sessionVariables = rec {
    PROTON_USE_WINED3D = 1; # Nvidia GTX 760 too old for proper Vulkan 1.3 needed by latest DXVK
  };

  boot.initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" "sr_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/mapper/luks-23612da4-dbc1-4d88-bc9c-32c0edbfefed";
      fsType = "btrfs";
      options = [ "subvol=@" ];
    };

  boot.initrd.luks.devices."luks-23612da4-dbc1-4d88-bc9c-32c0edbfefed".device = "/dev/disk/by-uuid/23612da4-dbc1-4d88-bc9c-32c0edbfefed";

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/90E0-3F61";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  fileSystems."/home" =
    { device = "/dev/mapper/luks-a8b836e2-427f-4ff9-ad35-879bb77ce82c";
      fsType = "btrfs";
    };

  boot.initrd.luks.devices."luks-a8b836e2-427f-4ff9-ad35-879bb77ce82c".device = "/dev/disk/by-uuid/a8b836e2-427f-4ff9-ad35-879bb77ce82c";

  swapDevices =
    [ { device = "/dev/mapper/luks-537d18a6-4ddd-4ff6-bbd8-eb636c6c1bf9"; }
    ];

  boot.initrd.luks.devices."luks-537d18a6-4ddd-4ff6-bbd8-eb636c6c1bf9".device = "/dev/disk/by-uuid/537d18a6-4ddd-4ff6-bbd8-eb636c6c1bf9";

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
