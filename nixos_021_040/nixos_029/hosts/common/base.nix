{ config, pkgs, ... }: {
  
  # Nix 配置
  nix.settings = {
  experimental-features = [ "nix-command" "flakes" ];
  substituters = [
    "https://mirrors.ustc.edu.cn/nix-channels/store"
    "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
    "https://cache.nixos.org/"
  ];
  download-buffer-size = 134217728;
};

  # 自动垃圾回收
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
  # 时区
  time.timeZone = "Asia/Shanghai";
  # 允许 unfree 软件
  nixpkgs.config.allowUnfree = true;
  # 系统版本
  system.stateVersion = "25.11";
}