{ config, pkgs, inputs, ... }:

{
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
    polarity = "dark";
    cursor = {
      # --- Bibata Cursors (bibata-cursors) ---
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      # 可选变体:
      # Bibata-Modern-Amber       Bibata-Modern-Amber-Right
      # Bibata-Modern-Classic     Bibata-Modern-Classic-Right
      # Bibata-Modern-Ice         Bibata-Modern-Ice-Right
      # Bibata-Original-Amber     Bibata-Original-Amber-Right
      # Bibata-Original-Classic   Bibata-Original-Classic-Right
      # Bibata-Original-Ice       Bibata-Original-Ice-Right

      # --- Capitaine Cursors (capitaine-cursors) ---
      # package = pkgs.capitaine-cursors;
      # name = "capitaine-cursors";
      # name = "capitaine-cursors-white";

      size = 24;
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
    gnome.enable = true;
  };

  environment.systemPackages = with pkgs; [
    base16-schemes
    bibata-cursors
  ];

  environment.sessionVariables = {
    XCURSOR_THEME = "Bibata-Modern-Ice";
    XCURSOR_SIZE = "24";
  };
}