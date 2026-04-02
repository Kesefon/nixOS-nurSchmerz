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

    agenix.url = "github:yaxitech/ragenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    plasma-manager.url = "github:nix-community/plasma-manager";
    plasma-manager.inputs.nixpkgs.follows = "nixpkgs";
    plasma-manager.inputs.home-manager.follows = "home-manager";

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
  outputs = inputs@{ nixpkgs, agenix, ... }: {
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
        agenix.nixosModules.default
      ];
    };
    nixosConfigurations.cloudbox = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      specialArgs = {
        inherit inputs;
      };
      modules = [
        ./compupars/cloudbox.nix
        agenix.nixosModules.default
      ];
    };
  };
}
