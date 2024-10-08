{
  description = "";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/24.05";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    snowlib.url = "github:xiro-codes/lib/update";
    cosmic.url = "github:lilyinstarlight/nixos-cosmic";

    disko.url = "github:nix-community/disko";
    impermanence.url = "github:nix-community/impermanence";
  };

  outputs = {
    self,
    nixpkgs,
    snowlib,
    ...
  } @ inputs:
    snowlib.mkFlake {
      inherit inputs;
      src = ./.;

      systems.modules.nixos = with inputs; [
        disko.nixosModules.default
        impermanence.nixosModules.impermanence
        cosmic.nixosModules.default
      ];

      homes.modules = with inputs; [
        impermanence.nixosModules.home-manager.impermanence
      ];

      channels-config.allowUnfree = true;
    };
}
