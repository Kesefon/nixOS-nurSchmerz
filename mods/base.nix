{ pkgs, lib, inputs, ... }:

{
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;

  system.autoUpgrade = {
    enable = true;
    upgrade = false;
    flake = "github:kesefon/nixOS-nurSchmerz/rolling";
    runGarbageCollection = true;
  };
  nix.gc.automatic = true;

  # Enable networking
  networking.networkmanager.enable = lib.mkDefault true;
  services.openssh = {
    enable = true;
    startWhenNeeded = true;
    settings.PermitRootLogin = "no";
    settings.PasswordAuthentication = false;
  };

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ALL = "en_US.UTF-8";
  };

  # Configure console keymap
  console.keyMap = lib.mkDefault "de";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kesefon = {
    isNormalUser = true;
    description = "Kesefon";
    extraGroups = [ "networkmanager" "wheel" "systemd-journal" ];
    openssh.authorizedKeys.keyFiles = [ inputs.ssh-keys.outPath ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    usbutils
    pciutils
    file
    git
    tree
    htop
  ];

  programs.fish.enable = true;

  programs.bash = {
    interactiveShellInit = ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    '';
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?
}
