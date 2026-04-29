{ config, pkgs, lib, ... }:

let
  mkOutOfStoreSymlink = config.lib.file.mkOutOfStoreSymlink;
  dotfilesDir = "/home/dy/dotfiles";  # 你的 dotfiles 目录
in {
  # 使用外部文件链接
  xdg.configFile."hypr/hyprland.conf" = {
    source = mkOutOfStoreSymlink "${dotfilesDir}/hypr/hyprland.conf";
    force = true;  # 强制覆盖已有文件
  };
}