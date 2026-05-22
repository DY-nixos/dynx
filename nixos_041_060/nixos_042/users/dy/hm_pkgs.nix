{ config, pkgs, ... }: {

  home.packages = with pkgs; [
    alacritty
    yazi
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
    capitaine-cursors
  ];

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    STEAM_FORCE_DESKTOPUI_SCALING = "1.5";
  };
}
