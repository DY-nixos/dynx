{ config, ... }:

{
  sops = {
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
    defaultSopsFile = ../secrets/secrets.yaml;  # 取消注释
    secrets = {
      GITHUB_TOKEN = { };  # 替换为 GITHUB_TOKEN
    };
  };
  
  # 作为环境变量
  home.sessionVariables = {
    GITHUB_TOKEN = "${config.sops.secrets.GITHUB_TOKEN.path}";
  };
}