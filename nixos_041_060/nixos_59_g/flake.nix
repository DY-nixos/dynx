{
  description = "NixOS multi-host configuration (modular, explicit imports)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    dms = {
      url = "github:AvengeMedia/DankMaterialShell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    deepseek-harness = {
      url = "github:moraxyc/deepseek-harness.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, sops-nix, deepseek-harness, ... }@inputs:
  let
    lib = nixpkgs.lib;

    mkHost = hostModule: lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        sops-nix.nixosModules.sops
        deepseek-harness.nixosModules.default
        hostModule
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = { inherit inputs; };
            backupFileExtension = "backup";
            users.dy = {
              imports = [ ./users/dy ];
            };
          };
        }
      ];
    };
  in
  {
    nixosConfigurations.dynx = mkHost ./hosts/dynx;
    nixosConfigurations.dynix = mkHost ./hosts/dynix;
  };
}