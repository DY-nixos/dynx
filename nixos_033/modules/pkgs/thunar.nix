{ config, pkgs, ... }:

{
  programs.thunar = {
    enable = true;
    plugins = with pkgs; [
      thunar-volman
      thunar-archive-plugin
    ];
  };
  programs.xfconf.enable = true;
  services.tumbler.enable = true;
  environment.systemPackages = with pkgs; [
    tumbler #提供图片预览功能
    libheif
    webp-pixbuf-loader
    libopenraw
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly
  ];
}