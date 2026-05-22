{ config, pkgs, inputs, ... }: {
  programs.hyprland = {
     enable = true;
     withUWSM = true;
     #package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
  };
}