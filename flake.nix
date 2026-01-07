# /etc/nixos/flake.nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    zen-browser.url = "github:youwen5/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };
  outputs = inputs@{ self, nixpkgs, nixos-hardware, ... }: {
    nixosConfigurations.shitbox = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit inputs;
      };
      modules = [
        ./common/desktop-base.nix
        ./compupars/shitbox.nix
      ];
    };
    nixosConfigurations.togobox = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit inputs;
      };
      modules = [
        ./common/desktop-base.nix
        ./compupars/togobox.nix
        nixos-hardware.nixosModules.chuwi-minibook-x
      ];
    };
  };
}
