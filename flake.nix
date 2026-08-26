{
  description = "NixOS from scratch";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-26.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
  };


  outputs =
    { self
    , nixpkgs
    , home-manager
    , nix-cachyos-kernel
    , ...
    }: {
      nixosConfigurations.Nxomb = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        specialArgs = {
          inherit nix-cachyos-kernel;
        };

        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.rayman = import ./home.nix;
              backupFileExtension = "backup";
            };
          }
        ];
      };
    };
}
