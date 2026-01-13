# /etc/nixos/flake.nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

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
  nixConfig = {
    extra-substituters = [
      "https://kesefon.cachix.org"
    ];
    extra-trusted-public-keys = [
      "kesefon.cachix.org-1:Z4qoXB2Qz56yg2GyESIatezeFyDKRZSAaJvtEFk32j8="
    ];
  };
  outputs = inputs@{ self, nixpkgs, nixos-hardware, nix-chuwi-minibook-x, ssh-keys, ... }: {
    nixosConfigurations.shitbox = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit inputs;
      };
      modules = [
        ./compupars/shitbox.nix
      ];
    };
    nixosConfigurations.togobox = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit inputs;
      };
      modules = [
        ./compupars/togobox.nix
      ];
    };
    nixosConfigurations.smolbox = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      specialArgs = {
        inherit inputs;
      };
      modules = [
        ./compupars/smolbox.nix
      ];
    };
  };
}
