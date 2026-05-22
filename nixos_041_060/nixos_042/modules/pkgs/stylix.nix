{ config, pkgs, ... }:

let
  isDark = false;
in
{
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/${if isDark then "nord" else "nord-light"}.yaml";
    polarity = if isDark then "dark" else "light";

    fonts = {
      sansSerif = {
        package = pkgs.noto-fonts-cjk-sans;
        name = "Noto Sans CJK SC";
      };
      serif = {
        package = pkgs.noto-fonts-cjk-serif;
        name = "Noto Serif CJK SC";
      };
      monospace = {
        package = pkgs.cascadia-code;
        name = "Cascadia Code";
      };
      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
      sizes = {
        applications = 12;
        desktop = 10;
        terminal = 12;
        popups = 10;
      };
    };

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
    gtk.enable = false;
    qt.enable = false;
    grub.enable = false;
  };
}