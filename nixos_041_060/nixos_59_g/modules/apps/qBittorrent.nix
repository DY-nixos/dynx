# 只用桌面 GUI 版。原来还开了 services.qbittorrent（qbittorrent-nox），
# 它和 GUI 是两套独立实例，且 WebUI 默认无密码却通过 openFirewall 暴露
# 8080 端口，风险较大，已移除。需要 headless 时再单独启用并设置 WebUI 密码。
{ pkgs, ... }:{ environment.systemPackages = with pkgs; [ qbittorrent ]; }