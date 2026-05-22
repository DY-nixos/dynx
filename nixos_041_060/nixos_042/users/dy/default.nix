{ config, pkgs, lib, ... }:

{
  home.username = "dy";
  home.homeDirectory = "/home/dy";
  home.stateVersion = "24.11";
  
  gtk.enable = lib.mkForce false;
  stylix.targets = {
    gtk.enable = false;
    qt.enable = false;
  };
  home.pointerCursor.enable = false;
}