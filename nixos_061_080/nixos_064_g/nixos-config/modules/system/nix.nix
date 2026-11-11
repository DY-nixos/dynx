{ config, pkgs, ... }:

{
  nix.settings = {
    trusted-users = [ "dy" ];
    experimental-features = [ "nix-command" "flakes" ];
    substituters = [
      # 只留实测可达的源。国内镜像(mirror.sjtu/ustc/tuna/cernet)在本机网络下
      # 全部 TLS 握手失败(SSL routines::unexpected eof while reading, 15s 超时),
      # 排在前面会导致每次构建先白等十几秒再回落, 所以不再使用。
      "https://cache.nixos.org/"
    ];
    #download-buffer-size = 134217728;
    auto-optimise-store = true;
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  nixpkgs.config.allowUnfree = true;

  time.timeZone = "Asia/Shanghai";
  system.stateVersion = "25.11";
}
