{ config, pkgs, inputs, ... }:

{
  home.username = "dy";
  home.homeDirectory = "/home/dy";
  home.stateVersion = "24.11";

  imports = [
    ./hm_pkgs.nix
    ./polkit.nix
    ./git.nix
    ./hyprland.nix
    ./fish.nix
    ./niri.nix
  ];
}