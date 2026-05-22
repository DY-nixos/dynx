{ config, pkgs, inputs, ... }:

{
  imports = [
    inputs.dms.homeModules.dank-material-shell
  ];

  programs.dank-material-shell = {
    enable = true;
    # 可选：开启系统监控等功能
    enableSystemMonitoring = true;
  };
}