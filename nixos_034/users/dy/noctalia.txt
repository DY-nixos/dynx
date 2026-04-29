{ config, pkgs, ... }: {

  # Noctalia 设置 - 使用 XDG 规范路径
  xdg.configFile = {
    #"noctalia/settings.json".source = ./noctalia/settings.json;
    #"noctalia/gui-settings.json".source = ./noctalia/gui-settings.json;
  };
}