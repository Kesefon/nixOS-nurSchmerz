{
  inputs,
  globals,
  specialArgs,
  lib,
  config,
  ...
}:

{
  home-manager.extraSpecialArgs = specialArgs;
  imports = [ inputs.home-manager.nixosModules.home-manager ];
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.sharedModules = [
    inputs.plasma-manager.homeModules.plasma-manager
    inputs.zen-browser.homeModules.beta
  ];

  home-manager.users."${globals.userinfo.username}" = lib.mkIf (!config.services.homed.enable) (
    (import ../home/home.nix) { inherit globals; }
  );
}
