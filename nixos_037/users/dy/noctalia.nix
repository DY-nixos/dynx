{ config, pkgs, lib, ... }:
let
  mkOutOfStoreSymlink = config.lib.file.mkOutOfStoreSymlink;
  configDir = "/home/dy/nixos-config";
in {
  xdg.configFile = {
    "noctalia/settings.json".source = mkOutOfStoreSymlink "${configDir}/dotfiles/noctalia/settings.json";
    #"noctalia/gui-settings.json".source = mkOutOfStoreSymlink "${configDir}/dotfiles/noctalia/gui-settings.json";
    #"noctalia/colors.json".source = mkOutOfStoreSymlink "${configDir}/dotfiles/noctalia/colors.json";
    #"noctalia/plugins.json".source = mkOutOfStoreSymlink "${configDir}/dotfiles/noctalia/plugins.json";
    "noctalia/user-templates.toml".source = mkOutOfStoreSymlink "${configDir}/dotfiles/noctalia/user-templates.toml";
  };
}