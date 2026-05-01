{
  description = "NixOS multi-host configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    quickshell.url = "git+https://git.outfoxxed.me/quickshell/quickshell";
    noctalia.url = "github:noctalia-dev/noctalia-shell";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
  let
    hostSystem = "x86_64-linux";
    lib = nixpkgs.lib;

    recursiveDirs = [
     ./modules
     ./hosts
    ];

    loadModulesFrom = path:
      if builtins.pathExists path then
        let
          entries = builtins.readDir path;
          names = builtins.attrNames entries;
          nixFiles = map (f: path + "/${f}")
            (builtins.filter (n: entries.${n} == "regular" && lib.hasSuffix ".nix" n) names);
        in
        nixFiles ++ lib.optionals (lib.any (d: lib.hasPrefix (toString d) (toString path)) recursiveDirs) (
          let
            subDirs = builtins.filter (n: entries.${n} == "directory") names;
          in
          builtins.concatMap (d: loadModulesFrom (path + "/${d}")) subDirs
        )
      else [];

    systemModules = loadModulesFrom ./modules;

    validUsers =
      if builtins.pathExists ./users then
        builtins.attrNames (lib.filterAttrs (_: type: type == "directory") (builtins.readDir ./users))
      else [];

    # 构建用户配置
    userConfigs = 
      if validUsers != [] then
        builtins.listToAttrs (map (username: {
          name = username;
          value = { config, pkgs, ... }: {
            imports = loadModulesFrom (./users + "/${username}");
          };
        }) validUsers)
      else {
        # 保底配置
        dy = { config, pkgs, ... }: {
          # 基础配置，确保 Home Manager 不会失败
          home.stateVersion = "24.11";
          programs.home-manager.enable = true;
        };
      };

    mkHost = hostName: hostConfig:
      lib.nixosSystem {
        specialArgs = { inherit inputs hostName; };
        modules = [
          { networking.hostName = hostName; }
          hostConfig
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit inputs; };
              users = userConfigs;
            };
          }
        ] ++ systemModules;
      };
  in
  {
    nixosConfigurations.dynx = mkHost "dynx" ./hosts/dynx/configuration.nix;
    nixosConfigurations.dynix = mkHost "dynix" ./hosts/dynix/configuration.nix;
  };
}