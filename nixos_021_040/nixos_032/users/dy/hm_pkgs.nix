{ config, pkgs, ... }: {

  home.packages = with pkgs; [
    alacritty
    fuzzel
    mpv
    obs-studio
    foliate
    loupe
    mupdf
    #pureref
    kdePackages.filelight
    kdePackages.partitionmanager
    xwayland-satellite
    nerd-fonts.jetbrains-mono
    bibata-cursors
    capitaine-cursors
  ];

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    XCURSOR_THEME = "capitaine-cursors";
    XCURSOR_SIZE = "15";
  };
}
