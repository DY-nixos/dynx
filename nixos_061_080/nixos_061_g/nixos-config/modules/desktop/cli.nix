{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # ===== 核心工具 =====
    alacritty              # 极快的 GPU 加速终端模拟器，Wayland 下表现良好
    yazi                   # 终端文件管理器（TUI），支持预览、批量重命名等，常配合终端使用
    fuzzel                 # Wayland 原生的应用启动器，类似 rofi 的 drun 模式
    xwayland-satellite     # 让 Wayland 合成器以 rootless 方式运行 Xwayland，兼容 X11 应用
    wget                   # 命令行下载工具，支持 HTTP/HTTPS/FTP
    curl                   # 命令行数据传输工具，常用于 API 调试和文件下载
    tree                   # 以树状结构列出目录内容，比 ls 更直观
    os-prober              # 探测系统中已安装的其他操作系统，用于 GRUB 生成多系统启动菜单
    fastfetch              # 系统信息展示工具（neofetch 的现代替代品），启动终端时显示系统概览
    btop                   # 交互式系统资源监视器，界面美观，显示 CPU/内存/磁盘/网络
    wtype                  # Wayland 下模拟键盘输入的工具（xdotool type 的 Wayland 替代）
    unzip                  # 解压 .zip 文件的命令行工具

    # ===== 桌面集成 =====
    gnome-font-viewer      # GNOME 字体查看器，可预览和安装字体文件[citation:1][citation:3]
    file-roller            # GNOME 归档管理器（图形界面），支持多种压缩格式[citation:1][citation:3]

    # ===== 解压后端（配合 file-roller）=====
    p7zip                  # 7z 格式的压缩/解压后端，file-roller 依赖它处理 .7z 文件
    #unrar                 # 处理 rar（NixOS 中可能需 unfree，或用 unar 替代）
    unar                   # 自由开源的 rar 解压工具，替代 unrar 以避免启用 unfree 软件源

    # ===== 图标主题 =====
    papirus-icon-theme     # 流行的扁平化图标主题，覆盖应用和文件夹图标
    tela-icon-theme        # 圆形风格图标主题，色彩鲜明
    whitesur-icon-theme    # 灵感来自 macOS 的图标主题，风格简洁
    nordzy-icon-theme      # 基于 Nord 配色方案的图标主题，冷色调

    # ===== 鼠标主题 =====
    capitaine-cursors      # macOS 风格的鼠标指针主题（你之前也问过这个）

    # ===== 驱动支持 =====
    libwacom               # Wacom 数位板/手绘板的设备识别库，让系统正确识别数位板型号

    # ===== 编辑器 =====
    mousepad               # Xfce 的轻量级图形文本编辑器，启动快，适合简单编辑

    # ===== 媒体库（缩略图与解码支持）=====
    ffmpegthumbnailer      # 视频缩略图生成器，文件管理器可借此显示视频文件的预览图[citation:15]
    poppler                # PDF 渲染库，文件管理器用它为 PDF 生成缩略图
    libheif                # HEIF/HEIC 图像格式的解码库（iPhone 照片常用格式）
    webp-pixbuf-loader     # 让 GTK 应用（如文件管理器）能显示 WebP 格式图片的加载器
    libopenraw             # RAW 相机文件解码库，支持多种相机厂商的 RAW 格式[citation:16]
  ];
}