{ pkgs, ... }:

{
  services.flatpak.enable = true;

  environment.systemPackages = with pkgs; [
    flatpak
    gnome-software
    bazaar
  ];

  # 国内 Flatpak 镜像现状（2026-10）：TUNA/BFSU/USTC 等的 flathub 路径
  # 均已 404，SJTU 只是 302 回 dl.flathub.org。因此不再维护镜像列表，
  # 直接确保官方 flathub remote 存在即可。以后有可用镜像时再加回来。
  systemd.services.configure-flatpak-repo = {
    description = "Configure Flatpak Flathub Remote";
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      set -e
      flatpak remote-add --if-not-exists --from flathub \
        https://dl.flathub.org/repo/flathub.flatpakrepo
      flatpak update --appstream
    '';
  };

  fonts.fontconfig.enable = true;
}