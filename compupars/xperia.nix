{ config, lib, pkgs, ... }:

{
  # Simply install just the packages
  environment.packages = with pkgs; [
    # User-facing stuff that you really really want to have
    vim # or some other editor, e.g. nano or neovim
    nano
    fish
    openssh
    git
    android-tools
    ffmpeg
    unixtools.ping
    pandoc
    #procps
    #killall
    #diffutils
    #findutils
    utillinux
    tzdata
    hostname
    pdftk
    imagemagick
    curl
    #man
    gnugrep
    #gnupg
    gnused
    gnutar
    bzip2
    gzip
    xz
    zip
    unzip
  ];

  # Backup etc files instead of failing to activate generation if a file already exists in /etc
  environment.etcBackupExtension = ".bak";

  environment.etc."resolv.conf".text = lib.mkForce ''
    nameserver 10.10.10.4
    nameserver 192.168.2.1
    nameserver 1.1.1.1
    nameserver 2606:4700:4700::1111
  '';

  # Read the changelog before changing this value
  system.stateVersion = "24.05";

  # Set up nix for flakes
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  # Set your time zone
  time.timeZone = "Europe/Berlin";

  terminal.font = "${pkgs.comic-mono}/share/fonts/ComicMono.ttf";

  user = {
    shell = "${pkgs.fish}/bin/fish";
  };
}
