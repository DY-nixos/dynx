{ config, pkgs, ... }:

{
  # 1. 允许安装 Steam 及其依赖的非自由软件包
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (pkgs.lib.getName pkg) [
    "steam"
    "steam-unwrapped"
    "steam-original"
    "steam-run"
  ];

  # 2. 硬件与图形驱动配置
  hardware = {
    # 启用 32 位图形驱动（对运行大量游戏至关重要）
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    # 为 Steam 手柄、Index VR 等硬件启用支持
    steam-hardware.enable = true;
  };

  # 3. Steam 主程序配置
  programs.steam = {
    enable = true;
    # 可选：如需使用 Steam 远程畅玩，请打开防火墙端口
    remotePlay.openFirewall = true;
    # 可选：如需搭建 Steam 专用服务器，请打开防火墙端口
    dedicatedServer.openFirewall = true;
    # 可选：如需在局域网内传输游戏文件，请打开防火墙端口
    localNetworkGameTransfers.openFirewall = true;
  };

  # 4. 可选：启用 GameMode 以优化游戏性能
  programs.gamemode.enable = true;
}