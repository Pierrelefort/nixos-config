{
  description = "Computers's nix configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: {

    nixosConfigurations = {
      server = nixpkgs.lib.nixosSystem {
        modules = [
          ./nixos/server/configuration.nix
        ];
      };
      framework = nixpkgs.lib.nixosSystem {
        modules = [
          ./nixos/framework/configuration.nix
        ];
      };
    };
  };
}
