{pkgs, ...}:
{
  home.packages = with pkgs; [
    noto-fonts-emoji-blob-bin
    comic-mono
    corefonts
    b612
  ];
  fonts = {
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "Comic Mono" ];
        emoji = [ "Blobmoji" "Noto Color Emoji" ];
      };
    };
  };
}
