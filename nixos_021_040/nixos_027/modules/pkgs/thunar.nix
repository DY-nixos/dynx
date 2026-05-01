{ config, pkgs, ... }:

{
  programs.thunar = {
    enable = true;
    plugins = with pkgs; [
      thunar-volman
      thunar-archive-plugin
    ];
  };
   
  programs.xfconf.enable = true;
}