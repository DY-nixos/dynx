{ config, pkgs, ... }:

{
  home.username = "dy";
  home.homeDirectory = "/home/dy";
  home.stateVersion = "24.11";

  imports = [
    ./hm_pkgs.nix
    ./polkit.nix
    ./git.nix
    ./niri.nix
  ];
  
  # 用户层只需要禁用光标冲突
  # Stylix 的配置已经在系统层完成了
  gtk.gtk4.theme = null;
  home.pointerCursor.enable = false;
}