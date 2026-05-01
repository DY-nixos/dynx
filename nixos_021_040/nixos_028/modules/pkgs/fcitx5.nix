{ config, pkgs, ... }: {
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      addons = with pkgs; [
        fcitx5-rime
        rime-data
        fcitx5-gtk
        qt6Packages.fcitx5-chinese-addons
        qt6Packages.fcitx5-configtool
      ];
      ignoreUserConfig = true;
      settings = {
        inputMethod = {
          "Groups/0" = {
            Name = "Default";
            "Default Layout" = "us";
            DefaultIM = "keyboard-us";
          };
          "Groups/0/Items/0" = { Name = "keyboard-us"; };
          "Groups/0/Items/1" = { Name = "rime"; };
          GroupOrder = { "0" = "Default"; };
        };
      };
    };
  };

}