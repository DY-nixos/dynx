{ config, lib, pkgs, ... }:

{
   environment.systemPackages = with pkgs; [ sops ];

  # sops-nix 系统级配置（模块已由 flake.nix 中的 nixosModules.sops 提供）
  sops = {
    age.keyFile = "/var/lib/sops-nix/age/keys.txt";
    defaultSopsFile = ../../secrets/secrets.yaml;
    secrets = {
      GITHUB_TOKEN = {
        owner = "dy";
      };
      # 给 root 的 nix 配置：绕过 GitHub API 限流（token 明文不进 git）
      NIX_ACCESS_TOKENS = {
        owner = "root";
        mode = "0644";
        path = "/root/.config/nix/nix.conf";
      };
    };
  };

  # 只暴露 secret 文件路径；fish 启动时会读取内容并设置真正的 GITHUB_TOKEN
  home-manager.users.dy.home.sessionVariables = {
    GITHUB_TOKEN_FILE = config.sops.secrets.GITHUB_TOKEN.path;
  };
}
