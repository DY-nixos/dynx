{ config, pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    # 核心工具
    alacritty
    yazi
    fuzzel
    xwayland-satellite
    wget
    curl
    tree
    os-prober
    fastfetch
    btop
    wtype
    unzip
    # 桌面集成
    gnome-font-viewer
    file-roller
    # 解压后端（配合 file-roller）
    p7zip          # 处理 7z
    #unrar          # 处理 rar（NixOS 中可能需 unfree，或用 unar 替代）
    unar         # 如果不想启用 unfree，用 unar 代替 unrar
    #图标主题
    papirus-icon-theme
    tela-icon-theme
    whitesur-icon-theme
    nordzy-icon-theme
    # 驱动支持
    libwacom
    # 编辑器
    mousepad
    # 媒体库
    ffmpegthumbnailer
    poppler
    libheif
    webp-pixbuf-loader
    libopenraw
  ];
}
