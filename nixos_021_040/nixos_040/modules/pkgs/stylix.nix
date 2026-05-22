{ config, pkgs, ... }:

let
  # 在这里切换：true = 深色，false = 浅色
  isDark = false;
in
{
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/${if isDark then "nord" else "nord-light"}.yaml";
    polarity = if isDark then "dark" else "light";
    
    cursor = {
      package = pkgs.bibata-cursors;
      name = if isDark then "Bibata-Modern-Classic" else "Bibata-Modern-Ice";
      size = 30;
    };
    
    icons = {
      enable = true;
      package = pkgs.papirus-icon-theme;
      dark = "Papirus-Dark";
      light = "Papirus-Light";
    };
  };

  stylix.targets = {
    gtk.enable = true;
    grub.enable = true;
  };
}