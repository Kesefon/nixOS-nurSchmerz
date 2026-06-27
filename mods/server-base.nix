{ ... }:

{
  imports = [
    ./service-fail-alert.nix
    ./base.nix
  ];

  system.autoUpgrade = {
    allowReboot = true;
    dates = "05:07";
    rebootWindow = {
      lower = "05:00";
      upper = "08:00";
    };
  };
}
