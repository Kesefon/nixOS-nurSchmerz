{ pkgs, lib, ... }:

{
  imports = [
    ./zen.nix
    ./base.nix
  ];

  # Enable OpenGL/Vulkan
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # TPM2
  # Note: Not all my machines have a tpm module
  security.tpm2.enable = true;
  security.tpm2.pkcs11.enable = true;  # expose /run/current-system/sw/lib/libtpm2_pkcs11.so
  security.tpm2.tctiEnvironment.enable = true;  # TPM2TOOLS_TCTI and TPM2_PKCS11_TCTI env variables

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Configure keymap in X11
  services.xserver.xkb = lib.mkDefault {
    layout = "de";
    variant = "";
  };

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    wayland.compositor = "kwin";
  };
  services.desktopManager.plasma6.enable = true;

  fonts = {
    packages = [
      pkgs.noto-fonts-emoji-blob-bin
      pkgs.comic-mono
      pkgs.corefonts
      pkgs.b612
    ];
    fontconfig.defaultFonts = {
      monospace = [ "Comic Mono" ];
      emoji = [ "Blobmoji" "Noto Color Emoji" ];
    };
  };

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kesefon = {
    isNormalUser = true;
    description = "Kesefon";
    extraGroups = [ "networkmanager" "wheel" "tss" "systemd-journal" ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    spotify
    kdePackages.kate
    discord
    mpv
    krita
    onlyoffice-desktopeditors
    xournalpp
    banana-cursor
  ];

  programs.steam = {
    localNetworkGameTransfers.openFirewall = true;
    enable = true;
  };

  programs.kdeconnect.enable = true;
}
