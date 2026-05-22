{ config, pkgs, ... }:

{
  # 32 位支持（必须）
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # 按需 unfree
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (pkgs.lib.getName pkg) [
      "steam"
      "steam-original"
      "steam-runtime"
    ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    gamescopeSession.enable = true;
  };

  programs.gamemode.enable = true;

  environment.systemPackages = with pkgs; [
    mangohud
    winetricks
    protonup-ng
    goverlay
  ];
}