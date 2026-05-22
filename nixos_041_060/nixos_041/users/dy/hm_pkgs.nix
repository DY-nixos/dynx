{ config, pkgs, ... }: {

  home.packages = with pkgs; [
    alacritty
    fuzzel
    mpv
    obs-studio
    foliate
    loupe
    fsearch
    mupdf
    zathura
    libreoffice
    pureref
    kdePackages.filelight
    kdePackages.partitionmanager
    xwayland-satellite
    nerd-fonts.jetbrains-mono
    bibata-cursors
    capitaine-cursors
  ];

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    STEAM_FORCE_DESKTOPUI_SCALING = "1.5";
  };
}
