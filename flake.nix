# /etc/nixos/flake.nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    zen-browser.url = "github:youwen5/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    nix-chuwi-minibook-x.url = "github:kesefon/nix-chuwi-minibook-x";
    nix-chuwi-minibook-x.inputs.nixpkgs.follows = "nixpkgs";
    nix-chuwi-minibook-x.inputs.nixos-hardware.follows = "nixos-hardware";

    ssh-keys = {
      url = "https://github.com/kesefon.keys";
      flake = false;
    };
  };
  outputs = inputs@{ self, nixpkgs, nixos-hardware, nix-chuwi-minibook-x, ssh-keys, ... }: {
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
        nix-chuwi-minibook-x.nixosModules.default
      ];
    };
    nixosConfigurations.smolbox = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      specialArgs = {
        inherit inputs;
      };
      modules = [
        ./common/base.nix
        ./common/nginx.nix
        ./common/postgresql.nix
        ./common/jellyfin.nix
        ./common/komga.nix
        ./common/immich.nix
        ./compupars/smolbox.nix
      ];
    };
  };
}
