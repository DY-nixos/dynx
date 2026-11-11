{ config, pkgs, lib, ... }: {

  # 系统级包 (需要root权限/系统驱动/桌面集成)
  environment.systemPackages = with pkgs; [
    
    baidupcs-go
    pureref
    # 系统监控
    #mission-center
  ];
}