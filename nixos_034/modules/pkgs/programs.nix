{ config, pkgs, lib, ... }: {

  programs.firefox.enable = true;
  programs.vim.enable = true;
  programs.git.enable = true;
  programs.fish.enable = true;
  programs.yazi.enable = true;

  # 系统级包 (需要root权限/系统驱动/桌面集成)
  environment.systemPackages = with pkgs; [
    # 核心工具
    wget
    curl
    tree
    os-prober
    fastfetch
    btop

    # 桌面集成
    gnome-font-viewer
    file-roller
    papirus-icon-theme

    # 驱动支持
    libwacom

    # 媒体库
    ffmpegthumbnailer
    poppler
    libheif
    webp-pixbuf-loader
    libopenraw

    # 编辑器
    mousepad

    # 系统监控
    mission-center

    # 3D (需要 CUDA/GPU 支持)
    blender
    opencode

  ];
}