{ pkgs, ... }:
{
  services.udev.extraRules = ''
    KERNEL=="video[0-9]*", SUBSYSTEM=="video4linux", SUBSYSTEMS=="usb", ATTRS{idVendor}=="046d", ATTRS{idProduct}=="094c", SYMLINK+="video-brio100", RUN+="${pkgs.v4l-utils}/bin/v4l2-ctl -d $devnode --set-ctrl=power_line_frequency=1"
  '';
}
