# /etc/nixos/flake.nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
  };
  outputs = inputs@{ self, nixpkgs, ... }: {
    nixosConfigurations.shitbox = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./common/desktop-base.nix
        ./compupars/shitbox.nix
      ];
    };
  };
}
