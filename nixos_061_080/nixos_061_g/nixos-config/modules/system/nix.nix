{ config, pkgs, ... }:

{
  nix.settings = {
    trusted-users = [ "dy" ];
    experimental-features = [ "nix-command" "flakes" ];
    substituters = [
      "https://mirror.sjtu.edu.cn/nix-channels/store"
      #"https://mirrors.ustc.edu.cn/nix-channels/store"
      #"https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
      #"https://cache.nixos.org/"
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
