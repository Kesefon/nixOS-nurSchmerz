{inputs, ...}:
let
  username = "kesefon";
  name = "Kesefon";
  email = "kesefon@froggo.garden";
in
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.sharedModules = [ inputs.plasma-manager.homeModules.plasma-manager ];

  home-manager.users."${username}" = import ../home/home.nix;
}
