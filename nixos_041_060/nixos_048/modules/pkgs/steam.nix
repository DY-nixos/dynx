{ config, pkgs, lib, ... }:

{
  # 1. 允许 unfree 包（Steam 必需）
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (pkgs.lib.getName pkg) [
      "steam"
      "steam-original"
      "steam-runtime"
      "proton-ge-bin"  # Proton 也需要
    ];

  # 2. 启用 32 位图形驱动（运行 Windows 游戏必需）
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # 3. Steam 主配置
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    gamescopeSession.enable = true;
    
    # ⭐ 关键：安装 Proton 兼容层（运行 Windows 游戏的必需品）
    extraCompatPackages = with pkgs; [
      proton-ge-bin           # 第三方优化版，兼容性最好（推荐）
      # proton-experimental   # 官方实验版（备选）
      # proton-full           # 官方完整版
    ];
  };

  # 4. GameMode（游戏性能优化）
  programs.gamemode.enable = true;

  # 5. 安装辅助工具
  environment.systemPackages = with pkgs; [
    mangohud               # 性能监控和帧数显示
    winetricks             # Wine 辅助工具
    protonup-ng            # 下载/管理 Proton 版本
    goverlay               # MangoHud 图形配置界面
    
    # 额外推荐（可选）
    # gamescope            # 微窗口游戏管理（已包含在 steam.gamescopeSession 中）
    # obs-studio           # 游戏录屏
  ];

  # 6. 可选：添加 32 位音频支持（减少兼容问题）
  services.pulseaudio.support32Bit = true;  # 如果使用 PulseAudio
  # services.pipewire.extraConfig.pipewire."92-low-latency" = { ... }; # PipeWire 用户参考
}