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
    #libreoffice
    # pureref  # hash mismatch, 联网后取消注释并运行 nix flake lock --update-input nixpkgs
    kdePackages.filelight
    kdePackages.partitionmanager
    xwayland-satellite
    nerd-fonts.jetbrains-mono
    capitaine-cursors
  ];

  home.sessionVariables = {
    STEAM_FORCE_DESKTOPUI_SCALING = "1.5";
  };
}
